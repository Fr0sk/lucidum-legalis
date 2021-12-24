import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/services/app_directories.dart';

enum OpenTabBodyResult { success, unsavedChanges }

class Api extends ChangeNotifier {
  final UserDatabase _db;
  //final _tabs = <TabState>[];
  //final _tabHistory = <TabState>[];
  final _openTabStateNotifier = ValueNotifier<TabState?>(null);
  final tabsNotifier = ValueNotifier<List<TabState>>([]);
  final tabHistoryNotifier = ValueNotifier<List<TabState>>([]);
  //TabState? _openTabState;

  Api() : _db = UserDatabase(databaseDir: AppDirectories.appDocDir);

  UserDatabase get database => _db;
  List<TabState> get tabs => tabsNotifier.value;
  List<TabState> get tabHistory => tabHistoryNotifier.value;
  //TabState? get openTabState => _openTabState;
  ValueNotifier<TabState?> get openTabStateNotifier => _openTabStateNotifier;

  Future<int> createClient() async {
    final id = await (_db.clientDao.insertClient(ClientsCompanion.insert(
        name: 'New Client'.tr(), type: const Value(ClientType.person))));
    await AppDirectories.getClientDir(id: id).create(recursive: true);
    return id;
  }

  Future<int>? createLawsuite() async {
    final id = await _db.lawsuiteDao.insertLawsuite(LawsuitesCompanion.insert(
        name: 'New Lawsuite'.tr(), state: LawsuiteState.open));
    await AppDirectories.getLawsuiteDir(id: id).create(recursive: true);
    return id;
  }

  Future<void> openClient({required int id, editMode = false}) async {
    /*if (_openTabState?.edit == true) {
      return OpenTabBodyResult.UNSAVED_CHANGES;
    }

    _openTabState = TabState<Client>(
        id: id, data: _db.clientDao.watchClientById(id), edit: editMode);
    notifyListeners();
    return OpenTabBodyResult.SUCCESS;*/

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
      tabsNotifier.notifyListeners();
    } else {
      // Removes the TabState from the history.
      // It will be added as the last element later
      tabHistory.remove(tabs[idx]);
    }

    // Adds the new or existing TabState to the end of history
    tabHistory.add(tabs[idx]);
    tabHistoryNotifier.notifyListeners();

    notifyListeners();
  }

  Future<OpenTabBodyResult> openLawsuite(
      {required int id, editMode = false}) async {
    if (_openTabStateNotifier.value?.edit == true) {
      return OpenTabBodyResult.unsavedChanges;
    }

    _openTabStateNotifier.value = TabState<Lawsuite>(
        id: id,
        dataStream: _db.lawsuiteDao.watchLawsuiteById(id),
        edit: editMode);
    notifyListeners();
    return OpenTabBodyResult.success;
  }

  void closeTab({required TabState tabState}) {
    if (tabs.contains(tabState)) {
      tabs.remove(tabState);
      tabsNotifier.notifyListeners();
      tabHistory.remove(tabState);
      tabHistoryNotifier.notifyListeners();
    }
  }

  Future<bool>? saveClient(Insertable<Client> client) =>
      _db.clientDao.updateClient(client);

  Future<bool>? saveLawsuite(Insertable<Lawsuite> lawsuite) {
    // TODO: implement saveClient
    throw UnimplementedError();
  }

  Future<bool>? deleteClient(Client client) async =>
      (await _db.clientDao.deleteClient(client)) == 1;

  Future<bool>? deleteLawsuite(Lawsuite lawsuite) async {
    // TODO: implement deleteLawsuite
    throw UnimplementedError();
  }
}