import 'package:drift/drift.dart';

enum LawsuiteState { open, waiting, closed, requiresAttention }

class Lawsuites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get state => intEnum<LawsuiteState>()();
  TextColumn get against => text().nullable()();
  TextColumn get processNumber => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get court => text().nullable()();
  TextColumn get judgement => text().nullable()();
  TextColumn get form => text().nullable()();
  TextColumn get legalSupportNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
