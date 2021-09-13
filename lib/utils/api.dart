import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/data/user.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/services/app_settings.dart';
import 'package:lucidum_legalis/utils/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';

enum LoadUserResult { SUCCESS, NOT_FOUND, EMPTY_USERNAME, ERROR }
enum CreateUserResult { SUCCESS, ALREADY_EXISTS, EMPTY_USERNAME, ERROR }
enum OpenTabBodyResult { SUCCESS, UNSAVED_CHANGES }

abstract class Api extends ChangeNotifier {
  User? get user;
  TabState? get openTabState;

  Future<LoadUserResult> loadUser(String username);
  Future<bool> unloadUser();
  Future<CreateUserResult> createUser(String username, String password);
  void closeTab();
  Future<int>? createClient();
  Future<int>? createLawsuite();
  Future<OpenTabBodyResult> openClient({required int id, bool editMode});
  Future<OpenTabBodyResult> openLawsuite({required int id, bool editMode});
  Future<bool>? saveClient(Insertable<Client> client);
  Future<bool>? saveLawsuite(Insertable<Lawsuite> lawsuite);
  Future<bool>? deleteClient(Client client);
  Future<bool>? deleteLawsuite(Lawsuite lawsuite);
}

class LocalApi with ChangeNotifier implements Api {
  User? _user;
  TabState? _openTabState;

  @override
  User? get user => _user;

  @override
  TabState? get openTabState => _openTabState;

  @override
  Future<LoadUserResult> loadUser(String username) async {
    // Check if username is valid
    username = username.trim();
    if (username.isEmpty) {
      return LoadUserResult.EMPTY_USERNAME;
    }

    try {
      final userFile = User.getUserFile(username);
      // Check if user exists
      if (!await userFile.exists()) {
        return LoadUserResult.NOT_FOUND;
      }

      // Loads user
      final contents = await userFile.readAsString();
      _user = User.fromJson(jsonDecode(contents));
      notifyListeners();

      return LoadUserResult.SUCCESS;
    } catch (err) {
      return LoadUserResult.ERROR;
    }
  }

  @override
  Future<bool> unloadUser() async {
    if (_user == null) {
      return false;
    }
    await _user!.db.close();
    _user = null;
    _openTabState = null;

    AppSettings().savedUser = '';
    await AppSettings().save();

    notifyListeners();
    return true;
  }

  @override
  Future<CreateUserResult> createUser(String username, String password) async {
    // Check if username is valid
    username = username.trim();
    if (username.isEmpty) {
      return CreateUserResult.EMPTY_USERNAME;
    }

    // Check if user already exists
    final userFile = User.getUserFile(username);
    if (await userFile.exists()) {
      return CreateUserResult.ALREADY_EXISTS;
    }

    try {
      // Creates user
      final user = User(
        username: username,
        name: username,
        password: password,
      );
      await userFile.create(recursive: true);
      await userFile.writeAsString(jsonEncode(user));
      await user.createDirectories();

      // Creates user database
      await user.db.ensureOpen();
      await user.db.close();

      return CreateUserResult.SUCCESS;
    } catch (err) {
      Logger.error(key: toString(), message: 'Failed to create user: $err');
      return CreateUserResult.ERROR;
    }
  }

  @override
  void closeTab() {
    _openTabState = null;
    notifyListeners();
  }

  @override
  Future<int> createClient() async {
    assert(user != null);

    final id = await (_user!.db.clientDao.insertClient(ClientsCompanion.insert(
        name: 'New Client'.tr(), type: ClientType.person)));
    await user?.getClientDir(id: id).create();
    return id;
  }

  @override
  Future<int>? createLawsuite() =>
      _user?.db.lawsuiteDao.insertLawsuite(LawsuitesCompanion.insert(
          name: 'New Lawsuite'.tr(), state: LawsuiteState.open));

  @override
  Future<OpenTabBodyResult> openClient(
      {required int id, editMode = false}) async {
    assert(user != null);

    if (_openTabState?.edit == true) {
      return OpenTabBodyResult.UNSAVED_CHANGES;
    }

    _openTabState = TabState<Client>(
        id: id, data: user!.db.clientDao.watchClientById(id), edit: editMode);
    notifyListeners();
    return OpenTabBodyResult.SUCCESS;
  }

  @override
  Future<OpenTabBodyResult> openLawsuite(
      {required int id, editMode = false}) async {
    assert(user != null);

    if (_openTabState?.edit == true) {
      return OpenTabBodyResult.UNSAVED_CHANGES;
    }

    _openTabState = TabState<Lawsuite>(
        id: id,
        data: user!.db.lawsuiteDao.watchLawsuiteById(id),
        edit: editMode);
    notifyListeners();
    return OpenTabBodyResult.SUCCESS;
  }

  @override
  Future<bool>? saveClient(Insertable<Client> client) =>
      _user?.db.clientDao.updateClient(client);

  @override
  Future<bool>? saveLawsuite(Insertable<Lawsuite> lawsuite) {
    // TODO: implement saveClient
    throw UnimplementedError();
  }

  @override
  Future<bool>? deleteClient(Client client) async =>
      (await _user?.db.clientDao.deleteClient(client)) == 1;

  @override
  Future<bool>? deleteLawsuite(Lawsuite lawsuite) async {
    // TODO: implement deleteLawsuite
    throw UnimplementedError();
  }
}
