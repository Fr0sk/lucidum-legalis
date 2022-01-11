import 'package:drift/drift.dart';

enum AlertType { client, lawsuite, clientNote, lawsuiteNote }

class Alerts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get type => intEnum<AlertType>()();
  BoolColumn get emitted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get emitAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get metadata => text().nullable()();
}
