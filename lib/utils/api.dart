import 'dart:io';

import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/list_notifier.dart';
import 'package:lucidum_legalis/utils/utils.dart';

enum OpenTabBodyResult { success, unsavedChanges }

enum FileSystemOperation { none, copy, move }

class Api {
  final UserDatabase _db;
  final tabs = ListNotifier<TabState>([]);
  final tabHistory = ListNotifier<TabState>([]);
  final selectedFiles = ListNotifier<FileSystemEntity>([]);
  var fileOperation = FileSystemOperation.none;

  Api() : _db = UserDatabase(databaseDir: AppDirectories.appDocDir);

  UserDatabase get database => _db;
  TabState? get openTabState => tabHistory.isEmpty ? null : tabHistory.last;

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
    final id = await _db.clientDao.insertClient(
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
    final id = await _db.lawsuiteDao.insertLawsuite(
      LawsuitesCompanion.insert(
        name: 'New Lawsuite'.tr(),
        state: LawsuiteState.open,
        createdAt: DateTime.now(),
      ),
    );
    await AppDirectories.getLawsuiteDir(id: id).create(recursive: true);
    return id;
  }

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
        dataStream: _db.clientDao.watchClientById(id),
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

  Future<void> openLawsuite({required int id, bool editMode = false}) async {
    // Checks if there is a Lawsuite tab with the same ID opened and
    // retreives it's index
    var idx = tabs.indexWhere((ts) => ts is TabState<Lawsuite> && ts.id == id);

    // If the tab isn't already open, create a new TabState object
    // to represent the tab and add it to the _tabs array
    if (idx < 0) {
      idx = tabs.length;
      tabs.add(TabState<Lawsuite>(
        id: id,
        dataStream: _db.lawsuiteDao.watchLawsuiteById(id),
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
      _db.clientDao.updateClient(client);

  Future<bool> saveLawsuite(Insertable<Lawsuite> lawsuite) =>
      _db.lawsuiteDao.updateLawsuite(lawsuite);

  Future<bool> deleteClient(Client client) async =>
      (await _db.clientDao.deleteClient(client)) == 1;

  Future<bool> deleteLawsuite(Lawsuite lawsuite) async =>
      (await _db.lawsuiteDao.deleteLawsuite(lawsuite)) == 1;

  Future<bool> associateClientLawsuiteByIds(
          int clientId, int lawsuiteId) async =>
      (await _db.clientLawsuiteDao.insertAssociation(ClientsLawsuitesCompanion(
          clientId: Value(clientId), lawsuiteId: Value(lawsuiteId)))) ==
      1;

  Future<bool> associateClientLawsuite(Client client, Lawsuite lawsuite) =>
      associateClientLawsuiteByIds(client.id, lawsuite.id);

  Future<bool> deleteClientLawsuiteAssociationByIds(
          int clientId, int lawsuiteId) async =>
      (await _db.clientLawsuiteDao
          .deleteAssociationByIds(clientId, lawsuiteId)) ==
      1;

  Future<bool> deleteClientLawsuiteAssociation(
          Client client, Lawsuite lawsuite) =>
      deleteClientLawsuiteAssociationByIds(client.id, lawsuite.id);
}
