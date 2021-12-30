import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/alerts.dart';
import 'package:lucidum_legalis/database/user_database.dart';

part 'alert_dao.g.dart';

@DriftAccessor(tables: [Alerts])
class AlertDao extends DatabaseAccessor<UserDatabase> with _$AlertDaoMixin {
  AlertDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertAlert(Insertable<Alert> alert) =>
      into(alerts).insert(alert);

  // Reads
  Future<List<Alert>> getAll() =>
      (select(alerts)..orderBy([(t) => OrderingTerm(expression: t.emitAt)]))
          .get();

  Future<List<Alert>> getNotEmitted() => (select(alerts)
        ..where((alert) => alert.emitted.equals(false))
        ..orderBy([(t) => OrderingTerm(expression: t.emitAt)]))
      .get();

  Stream<List<Alert>> watchAll() =>
      (select(alerts)..orderBy([(t) => OrderingTerm(expression: t.emitAt)]))
          .watch();

  Stream<List<Alert>> watchNotEmitted() => (select(alerts)
        ..where((alert) => alert.emitted.equals(false))
        ..orderBy([(t) => OrderingTerm(expression: t.emitAt)]))
      .watch();

  // Updates
  Future<bool> updateAlert(Insertable<Alert> alert) =>
      update(alerts).replace(alert);

  Future<bool> markEmitted(Alert alert) async =>
      await (update(alerts)..where((tbl) => tbl.id.equals(alert.id)))
          .write(const AlertsCompanion(emitted: Value(true))) ==
      1;

  // Deletes
  Future<bool> deleteAlert(Alert alert) async =>
      await delete(alerts).delete(alert) == 1;
}
