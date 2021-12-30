import 'package:drift/drift.dart';

import 'app_notifications.dart';

class Alerts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get type => intEnum<NotificationType>().nullable()();
  BoolColumn get emitted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get emitAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
