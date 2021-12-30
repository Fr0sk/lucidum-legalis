import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:lucidum_legalis/database/daos/alert_dao.dart';
import 'package:lucidum_legalis/database/daos/client_dao.dart';
import 'package:lucidum_legalis/database/daos/lawsuite_dao.dart';
import 'package:lucidum_legalis/database/daos/notification_dao.dart';
import 'package:lucidum_legalis/database/tables/client_notes.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/clients_lawsuites.dart';
import 'package:lucidum_legalis/database/tables/contacts.dart';
import 'package:lucidum_legalis/database/tables/lawsuite_notes.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/tables/app_notifications.dart';
import 'package:lucidum_legalis/database/tables/settings.dart';
import 'package:lucidum_legalis/database/tables/alerts.dart';
import 'package:sqlite3/open.dart';
import 'package:path/path.dart' as p;

part 'user_database.g.dart';

@DriftDatabase(tables: [
  ClientNotes,
  ClientsLawsuites,
  Clients,
  Contacts,
  LawsuiteNotes,
  Lawsuites,
  Settings,
  AppNotifications,
  Alerts
], daos: [
  ClientDao,
  LawsuiteDao,
  AlertDao,
  NotificationDao
])
class UserDatabase extends _$UserDatabase {
  static void setupSqlitePlatformOverrides() {
    //final script = File(Platform.script.toFilePath());
    open.overrideFor(
        OperatingSystem.linux, () => DynamicLibrary.open('libsqlite.so'));
    open.overrideFor(
        OperatingSystem.windows, () => DynamicLibrary.open('sqlite3.dll'));
  }

  static QueryExecutor _openConnection({required String userFolder}) {
    final file = File(p.join(userFolder, 'app.db'));
    return NativeDatabase(file);
  }

  UserDatabase({required Directory databaseDir})
      : super(_openConnection(userFolder: databaseDir.path));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreing_keys = ON');
      },
      onUpgrade: (migrator, from, to) async {});
}
