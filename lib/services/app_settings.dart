import 'package:flutter/widgets.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';

class AppSettings {
  static const checkForUpdatesKey = 'checkForUpdates';

  late final checkForUpdates = ValueNotifier<bool>(true);
  late final UserDatabase db;

  var _isInitialized = false;

  Future<void> ensureInitialized() async {
    if (_isInitialized) {
      return;
    }
    db = api.database;

    // Check for updates (default: true)
    checkForUpdates.value =
        (await db.settingsDao.getValue(checkForUpdatesKey) ?? // DB Value
                true.toString()) == // Default value
            true.toString(); // Convert to bool
    checkForUpdates.addListener(() async {
      await db.settingsDao
          .insertOrUpdate(checkForUpdatesKey, checkForUpdates.value.toString());
    });

    _isInitialized = true;
  }
}
