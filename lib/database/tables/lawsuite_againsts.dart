import 'package:drift/drift.dart';

class LawsuiteAgainsts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get against => text().nullable()();
  TextColumn get vat => text().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get lawsuiteId =>
      integer().customConstraint('REFERENCES lawsuites(id)')();
}
