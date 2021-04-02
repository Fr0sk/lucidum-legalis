import 'dart:io';

import 'package:lucidum_legalis/database/clients.dart';
import 'package:lucidum_legalis/database/users.dart';
import 'package:lucidum_legalis/utils/helpers/database_helper.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

/*class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}*/

@UseMoor(tables: [Users, Clients], daos: [UserDao, ClientDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(Directory dbFolder)
      : super(DatabaseHelper.openConnection(dbFolder));

  @override
  int get schemaVersion => 1;
}
