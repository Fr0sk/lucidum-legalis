import 'package:drift/drift.dart';

class ClientNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get clientId =>
      integer().customConstraint('REFERENCES clients(id)')();
}
