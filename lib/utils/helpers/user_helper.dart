import 'dart:io';
import 'package:lucidum_legalis/database/database.dart';
import 'package:lucidum_legalis/utils/services/settings_storage_service.dart';
import 'package:path/path.dart' as p;

class UserHelper {
  static Future<Directory> getUserFolder(String username) async {
    var usersPath = await SettingsStorageService().usersPath;
    return Directory(p.join(usersPath, username));
  }

  static Future<bool> userExists(String username) async {
    return (await getUserFolder(username)).exists();
  }

  static Future<bool> createNewAccount(String username, String password) async {
    if (await userExists(username)) {
      return false;
    }

    var path = await (await getUserFolder(username)).create(recursive: true);

    var db = AppDatabase(await getUserFolder(username));
    await db.userDao.createOrUpdateUser(
        User(username: username, displayName: username, password: password));
    await db.close();

    return await path.exists();
  }
}
