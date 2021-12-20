import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AppSettings {
  //static final _USERS_DIR = 'usersDir';
  //static final _SAVED_USER = 'savedUser';

  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal();

  late String usersDir;
  //late String savedUser;

  Future<bool> save() async {
    /*final prefs = await SharedPreferences.getInstance();
    var success = true;

    success = success && await prefs.setString(_USERS_DIR, usersDir);
    success = success && await prefs.setString(_SAVED_USER, savedUser);

    return success;*/
    return true;
  }

  Future<void> load() async {
    /*final prefs = await SharedPreferences.getInstance();
    usersDir = prefs.getString(_USERS_DIR) ??
        '${(await getApplicationDocumentsDirectory()).path}/${App.Title}';
    savedUser = prefs.getString(_SAVED_USER) ?? '';*/
    usersDir =
        p.join((await getApplicationDocumentsDirectory()).path, App.Title);
  }
}
