import 'dart:ffi';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucidum_legalis/database/daos/alert_dao.dart';
import 'package:lucidum_legalis/database/daos/client_dao.dart';
import 'package:lucidum_legalis/database/daos/client_lawsuite_dao.dart';
import 'package:lucidum_legalis/database/daos/lawsuite_dao.dart';
import 'package:lucidum_legalis/database/tables/client_notes.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/clients_lawsuites.dart';
import 'package:lucidum_legalis/database/tables/contacts.dart';
import 'package:lucidum_legalis/database/tables/lawsuite_againsts.dart';
import 'package:lucidum_legalis/database/tables/lawsuite_notes.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
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
  Alerts,
  LawsuiteAgainsts
], daos: [
  ClientDao,
  LawsuiteDao,
  AlertDao,
  ClientLawsuiteDao,
])
class UserDatabase extends _$UserDatabase {
  static void setupSqlitePlatformOverrides() {
    //final script = File(Platform.script.toFilePath());
    open.overrideFor(
        OperatingSystem.linux, () => DynamicLibrary.open('libsqlite.so'));
    open.overrideFor(
        OperatingSystem.windows, () => DynamicLibrary.open('sqlite3.dll'));
  }

  static Future<void> backup({required Directory databaseDir}) async {
    final bakupFolder = Directory(p.join(databaseDir.path, 'backup'));
    await bakupFolder.create();

    final dbFile = File(p.join(databaseDir.path, 'app.db'));
    final dbBackFileName =
        DateFormat('yyyy-MM-dd_hh-mm-ss').format(DateTime.now());

    await dbFile.copy(p.join(bakupFolder.path, 'app_$dbBackFileName.db'));
  }

  static QueryExecutor _openConnection({required String userFolder}) {
    final file = File(p.join(userFolder, 'app.db'));
    return NativeDatabase(file);
  }

  UserDatabase({required Directory databaseDir})
      : super(_openConnection(userFolder: databaseDir.path));

  @override
  int get schemaVersion => 5; // Database version

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreing_keys = ON');
        },
        onCreate: (migrator) {
          return migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from <= 1) {
            await migrator.alterTable(TableMigration(lawsuites));
            await migrator.alterTable(TableMigration(clients));
          }
          if (from <= 2) {
            await migrator.addColumn(lawsuiteAgainsts, lawsuiteAgainsts.vat);
            await migrator.deleteTable('app_notifications');
          }
          if (from <= 3) {
            await migrator.addColumn(
                lawsuiteAgainsts, lawsuiteAgainsts.address);
          }
          if (from <= 4) {
            await migrator.addColumn(lawsuiteAgainsts, lawsuiteAgainsts.vat);
          }
        },
      );
}
