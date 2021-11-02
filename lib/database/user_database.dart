import 'dart:io';

import 'package:lucidum_legalis/database/daos/client_dao.dart';
import 'package:lucidum_legalis/database/daos/lawsuite_dao.dart';
import 'package:lucidum_legalis/database/tables/client_notes.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/clients_lawsuites.dart';
import 'package:lucidum_legalis/database/tables/contacts.dart';
import 'package:lucidum_legalis/database/tables/lawsuite_notes.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/tables/settings.dart';
import 'package:lucidum_legalis/utils/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path/path.dart' as p;

part 'user_database.g.dart';

const SQLITE_ERR_NOTADB = 26;

QueryExecutor _openConnection({required String userFolder}) {
  final file = File(p.join(userFolder, 'db.sqlite'));
  return VmDatabase(file);
}

@UseMoor(tables: [
  ClientNotes,
  ClientsLawsuites,
  Clients,
  Contacts,
  LawsuiteNotes,
  Lawsuites,
  Settings
], daos: [
  ClientDao,
  LawsuiteDao
])
class UserDatabase extends _$UserDatabase {
  UserDatabase({required String userFolder})
      : super(_openConnection(userFolder: userFolder));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreing_keys = ON');
      },
      onUpgrade: (migrator, from, to) async {});

  Future<void> ensureOpen() async {
    await select(settings).get();
  }

  Future<bool> unlock(String password) async {
    try {
      await customStatement('PRAGMA key = \'$password\';');
      await ensureOpen();
      return true;
    } catch (e) {
      if (e is SqliteException && e.extendedResultCode == SQLITE_ERR_NOTADB) {
        return false;
      }
      rethrow;
    }
  }

  Future<bool> changePassword(String newPassword) async {
    try {
      await customStatement('PRAGMA rekey = \'$newPassword\';');
      return true;
    } catch (e) {
      Logger.error(key: toString(), message: e.toString());
      return false;
    }
  }
}
