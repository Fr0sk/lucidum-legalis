import 'package:drift/drift.dart';

enum NotificationType { normal, client, lawsuite }

class AppNotifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get type => intEnum<NotificationType>().nullable()();
  BoolColumn get emitted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
