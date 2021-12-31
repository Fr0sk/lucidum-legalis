import 'package:drift/drift.dart';

@DataClassName('ClientLawsuite')
class ClientsLawsuites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId =>
      integer().customConstraint('REFERENCES clients(id)')();
  IntColumn get lawsuiteId =>
      integer().customConstraint('REFERENCES lawsuites(id)')();
}
