import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/user_database.dart';

import '../tables/settings.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<UserDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertSetting(Insertable<Setting> setting) =>
      into(settings).insert(setting);

  Future<int> insertOrUpdate(String key, String value) async {
    final setting = await getSetting(key);
    if (setting == null) {
      return insertSetting(
          SettingsCompanion(name: Value(key), value: Value(value)));
    } else {
      update(settings).replace(setting.copyWith(value: value));
      return setting.id;
    }
  }

  // Reads
  Future<Setting?> getSetting(String key) async {
    try {
      final setting = await (select(settings)
            ..where((tbl) => tbl.name.equals(key)))
          .getSingle();
      return setting;
    } catch (_) {
      return null;
    }
  }

  Future<String?> getValue(String key) async {
    return (await getSetting(key))?.value;
  }

  // Updates
  Future<int> updateSetting(String key, String value) =>
      (update(settings)..where((tbl) => tbl.name.equals(key)))
          .write(SettingsCompanion(value: Value(value)));

  // Deletes
  Future<bool> deleteSetting(Setting setting) async =>
      await delete(settings).delete(setting) == 1;
}
