import 'package:crypt/crypt.dart';
import 'package:flutter/widgets.dart';
import 'package:lucidum_legalis/database/database.dart';
import 'package:lucidum_legalis/utils/helpers/user_helper.dart';
import 'package:lucidum_legalis/utils/services/settings_storage_service.dart';

enum LoadUserStatus { Ok, UserNotFound, WrongPassword }

class AppModel extends ChangeNotifier {
  AppDatabase _db;
  User _user;

  Future<LoadUserStatus> loadUser(
      {@required String username, String password = ''}) async {
    /*if (username == _user?.username) {
      return LoadUserStatus.Ok;
    }*/

    if (_db != null) {
      //await _db.close();
      await logout();
    }
    var dbPath = await UserHelper.getUserFolder(username);

    if (!await UserHelper.userExists(username)) {
      return LoadUserStatus.UserNotFound;
    }

    _db = AppDatabase(dbPath);
    var loadedUser = await _db?.userDao?.getUuser();

    if (loadedUser?.password == null) {
      // If can't read password from db
      return LoadUserStatus.WrongPassword;
    }

    if (loadedUser.password.isNotEmpty) {
      // If password exists in db
      final hashed = Crypt(loadedUser?.password);
      if (!hashed.match(password)) {
        // Crypt validate
        return LoadUserStatus.WrongPassword;
      }
    }

    _user = loadedUser;
    notifyListeners();
    return LoadUserStatus.Ok;
  }

  Future<void> logout() async {
    if (_db != null) {
      await _db.close();
    }

    _db = null;
    _user = null;
    await SettingsStorageService().setRememberedUser(null);

    notifyListeners();
  }

  User get user => _user;

  AppDatabase get database => _db;
}
