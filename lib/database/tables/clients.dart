import 'package:drift/drift.dart';

enum ClientType { person, company }

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get type => intEnum<ClientType>()();
  TextColumn get idNumber => text().nullable()();
  IntColumn get taxNumber => integer().nullable()();
  TextColumn get civilStatus => text().nullable()();
  TextColumn get street => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  TextColumn get city => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
