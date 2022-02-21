import 'package:flutter/widgets.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';

class AppSettings {
  static const checkForUpdatesKey = 'checkForUpdates';
  static const saveOpenTabsKey = 'saveOpenTabs';
  static const openTabsKey = 'openTabs';
  static const openTabsHistoryKey = 'openTabsHistory';
  static const isWindowMaximizedKey = 'isWindowMaximized';

  late final checkForUpdates = ValueNotifier<bool>(true);
  late final saveOpenTabs = ValueNotifier<bool>(true);
  late final openTabs = ValueNotifier<String>('');
  late final openTabsHistory = ValueNotifier<String>('');
  late final isWindowMaximized = ValueNotifier<bool>(false);
  late final UserDatabase db;

  var _isInitialized = false;

  Future<void> ensureInitialized() async {
    if (_isInitialized) {
      return;
    }
    db = userDatabase;

    // Check for updates
    checkForUpdates.value = await _getBool(
      key: checkForUpdatesKey,
      onNull: true,
    );
    checkForUpdates.addListener(() async => await _putBool(
          key: checkForUpdatesKey,
          value: checkForUpdates.value,
        ));

    // Save open tabs
    saveOpenTabs.value = await _getBool(
      key: saveOpenTabsKey,
      onNull: true,
    );
    saveOpenTabs.addListener(() async => await _putBool(
          key: saveOpenTabsKey,
          value: saveOpenTabs.value,
        ));

    // Open tabs
    openTabs.value = await _getString(key: openTabsKey);
    openTabs.addListener(() async => await _putString(
          key: openTabsKey,
          value: openTabs.value,
        ));

    // Open tabs history
    openTabsHistory.value = await _getString(key: openTabsHistoryKey);
    openTabsHistory.addListener(() async => await _putString(
          key: openTabsHistoryKey,
          value: openTabsHistory.value,
        ));

    // Is window maximized
    isWindowMaximized.value = await _getBool(key: isWindowMaximizedKey);
    isWindowMaximized.addListener(() async => await _putBool(
        key: isWindowMaximizedKey, value: isWindowMaximized.value));
    _isInitialized = true;
  }

  Future<String> _getString({required String key, String onNull = ''}) async {
    return await db.settingsDao.getValue(key) ?? onNull;
  }

  Future<bool> _getBool({required String key, bool onNull = false}) async {
    final val = await db.settingsDao.getValue(key);
    return val == null ? onNull : val == true.toString();
  }

  Future<void> _putString({required String key, required String value}) async {
    await db.settingsDao.insertOrUpdate(key, value);
  }

  Future<void> _putBool({required String key, required bool value}) async {
    await _putString(key: key, value: value.toString());
  }
}
