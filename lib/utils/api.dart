import 'dart:io';

import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/alerts.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_controller.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/list_notifier.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

enum OpenTabBodyResult { success, unsavedChanges }

enum FileSystemOperation { none, copy, move }

class Api {
  final OmniboxController omniboxController;
  final tabs = ListNotifier<TabState>([]);
  final tabHistory = ListNotifier<TabState>([]);
  final selectedFiles = ListNotifier<FileSystemEntity>([]);
  final openedReminder = ValueNotifier<Alert?>(null);
  var fileOperation = FileSystemOperation.none;

  Api()
      : omniboxController = OmniboxController(
            userDatabase.clientDao.watchAllClients(),
            userDatabase.lawsuiteDao.watchAllLawsuites());

  UserDatabase get database => userDatabase;
  TabState? get openTabState => tabHistory.isEmpty ? null : tabHistory.last;

  void showOmnibox() {
    omniboxController.show(
        hint: 'Search Anything'.tr(),
        onClientSelected: (client) {
          closeOmnibox();
          openClient(id: client.id);
        },
        onLawsuitSelected: (lawsuite) {
          closeOmnibox();
          openLawsuit(id: lawsuite.id);
        });
  }

  void closeOmnibox() {
    omniboxController.hide();
  }

  void toggleOmnibox() {
    if (omniboxController.visibility.value) {
      closeOmnibox();
    } else {
      showOmnibox();
    }
  }

  Future<void> copyFiles(List<FileSystemEntity> files) async {
    fileOperation = FileSystemOperation.copy;
    selectedFiles.replaceAll(files);
  }

  Future<void> cutFiles(List<FileSystemEntity> files) async {
    fileOperation = FileSystemOperation.move;
    selectedFiles.replaceAll(files);
  }

  Future<void> pasteFiles(Directory newDirectory) async {
    if (selectedFiles.isEmpty || fileOperation == FileSystemOperation.none) {
      return;
    }

    await Copy.list(selectedFiles.map((e) => e.path).toList(), newDirectory);
    if (fileOperation == FileSystemOperation.move) {
      for (var e in selectedFiles.value) {
        await e.delete(recursive: true);
      }
      fileOperation = FileSystemOperation.none;
      selectedFiles.clear();
    }
  }

  Future<int> createClient() async {
    final id = await userDatabase.clientDao.insertClient(
      ClientsCompanion.insert(
        name: 'New Client'.tr(),
        type: ClientType.person,
        createdAt: DateTime.now(),
      ),
    );
    await AppDirectories.getClientDir(id: id).create(recursive: true);
    return id;
  }

  Future<int> createLawsuite() async {
    final id = await userDatabase.lawsuiteDao.insertLawsuite(
      LawsuitesCompanion.insert(
        name: 'New Lawsuite'.tr(),
        state: LawsuiteState.open,
        createdAt: DateTime.now(),
      ),
    );
    await AppDirectories.getLawsuiteDir(id: id).create(recursive: true);
    return id;
  }

  Future<bool> openFile({required String file}) => launch(file);

  Future<void> openClient({required int id, bool editMode = false}) async {
    // Checks if there is a client tab with the same ID opened and
    // retreives it's index
    var idx = tabs.indexWhere((ts) => ts is TabState<Client> && ts.id == id);

    // If the tab isn't already open, create a new TabState object
    // to represent the tab and add it to the _tabs array
    if (idx < 0) {
      idx = tabs.length;
      tabs.add(TabState<Client>(
        id: id,
        dataStream: userDatabase.clientDao.watchClientById(id),
        edit: editMode,
      ));
    } else {
      // Removes the TabState from the history.
      // It will be added as the last element later
      tabHistory.remove(tabs[idx]);
    }

    // Adds the new or existing TabState to the end of history
    tabHistory.add(tabs[idx]);
  }

  Future<void> openLawsuit({required int id, bool editMode = false}) async {
    // Checks if there is a Lawsuite tab with the same ID opened and
    // retreives it's index
    var idx = tabs.indexWhere((ts) => ts is TabState<Lawsuite> && ts.id == id);

    // If the tab isn't already open, create a new TabState object
    // to represent the tab and add it to the _tabs array
    if (idx < 0) {
      idx = tabs.length;
      tabs.add(TabState<Lawsuite>(
        id: id,
        dataStream: userDatabase.lawsuiteDao.watchLawsuiteById(id),
        edit: editMode,
      ));
    } else {
      // Removes the TabState from the history.
      // It will be added as the last element later
      tabHistory.remove(tabs[idx]);
    }

    // Adds the new or existing TabState to the end of history
    tabHistory.add(tabs[idx]);
  }

  void closeTab({required TabState tabState}) {
    if (tabs.contains(tabState)) {
      tabs.remove(tabState);
      tabHistory.remove(tabState);
    }
  }

  Future<bool> saveClient(Insertable<Client> client) =>
      userDatabase.clientDao.updateClient(client);

  Future<bool> saveLawsuite(Insertable<Lawsuite> lawsuite) =>
      userDatabase.lawsuiteDao.updateLawsuite(lawsuite);

  Future<bool> deleteClient(Client client) async =>
      (await userDatabase.clientDao.deleteClient(client)) == 1;

  Future<bool> deleteLawsuite(Lawsuite lawsuite) async =>
      (await userDatabase.lawsuiteDao.deleteLawsuite(lawsuite)) == 1;

  Future<bool> associateClientLawsuiteByIds(
          int clientId, int lawsuiteId) async =>
      (await userDatabase.clientLawsuiteDao.insertAssociation(
          ClientsLawsuitesCompanion(
              clientId: Value(clientId), lawsuiteId: Value(lawsuiteId)))) ==
      1;

  Future<bool> associateClientLawsuite(Client client, Lawsuite lawsuite) =>
      associateClientLawsuiteByIds(client.id, lawsuite.id);

  Future<bool> deleteClientLawsuiteAssociationByIds(
          int clientId, int lawsuiteId) async =>
      (await userDatabase.clientLawsuiteDao
          .deleteAssociationByIds(clientId, lawsuiteId)) ==
      1;

  Future<bool> deleteClientLawsuiteAssociation(
          Client client, Lawsuite lawsuite) =>
      deleteClientLawsuiteAssociationByIds(client.id, lawsuite.id);

  Future<int> createLawsuiteReminder(int lawsuiteId) =>
      database.alertDao.insertAlert(
        AlertsCompanion.insert(
          type: AlertType.lawsuite,
          emitAt: DateTime.now().endDay,
          createdAt: DateTime.now(),
          metadata: Value(lawsuiteId.toString()),
        ),
      );

  Future<void> openReminder(int id) async =>
      openedReminder.value = await database.alertDao.getById(id);

  void closeReminder() => openedReminder.value = null;
}
