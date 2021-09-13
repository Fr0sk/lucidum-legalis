import 'package:moor_flutter/moor_flutter.dart';

enum ContactType { mobile, phone, email }

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get contactType => intEnum<ContactType>()();
  TextColumn get contact => text().nullable()();
  IntColumn get clientId =>
      integer().customConstraint('REFERENCES clients(id)')();
}
