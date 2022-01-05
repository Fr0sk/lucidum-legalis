import 'package:drift/drift.dart';

class LawsuiteAgainsts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get against => text().nullable()();
  IntColumn get lawsuiteId =>
      integer().customConstraint('REFERENCES lawsuites(id)')();
}
