import 'package:moor_flutter/moor_flutter.dart';

class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get value => text()();
}
