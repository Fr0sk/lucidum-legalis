import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/app_notifications.dart';
import 'package:lucidum_legalis/database/user_database.dart';

part 'notification_dao.g.dart';

@DriftAccessor(tables: [AppNotifications])
class NotificationDao extends DatabaseAccessor<UserDatabase>
    with _$NotificationDaoMixin {
  NotificationDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertNotification(Insertable<AppNotification> notif) =>
      into(appNotifications).insert(notif);

  // Reads
  Future<List<AppNotification>> getAll() => select(appNotifications).get();
  Future<List<AppNotification>> getNotEmitted() =>
      (select(appNotifications)..where((tbl) => tbl.emitted.equals(false)))
          .get();

  Stream<List<AppNotification>> watchAll() => select(appNotifications).watch();

  Stream<List<AppNotification>> watchNotEmitted() =>
      (select(appNotifications)..where((tbl) => tbl.emitted.equals(false)))
          .watch();

  // Updates
  Future<bool> updateAlert(Insertable<AppNotification> notif) =>
      update(appNotifications).replace(notif);

  Future<bool> markEmitted(AppNotification notif) async =>
      await (update(appNotifications)..where((tbl) => tbl.id.equals(notif.id)))
          .write(const AppNotificationsCompanion(emitted: Value(true))) ==
      1;

  // Deletes
  Future<bool> deleteAlert(AppNotification notif) async =>
      await delete(appNotifications).delete(notif) == 1;
}
