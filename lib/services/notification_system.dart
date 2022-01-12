import 'package:desktoasts/desktoasts.dart';
import 'package:lucidum_legalis/utils/constants.dart';
//import 'dart:io' show Platform;

class AppNotifications {
  final service = ToastService(
      appName: App.title, companyName: App.companyName, productName: App.title);

  AppNotifications() {
    service.stream.listen((event) {
      if (event is ToastDismissed) {
        // Toast dismissed
      } else if (event is ToastActivated) {
        // Clicks on toast
        //TODO: Interact with toast
      } else if (event is ToastInteracted) {
        // On toast action pressed
      }
    });
  }

  /*Future<List<AppNotification>> getAll() =>
      api.database.notificationDao.getAll();

  Future<List<AppNotification>> getUnread() =>
      api.database.notificationDao.getNotEmitted();

  Stream<List<AppNotification>> watchUnread() =>
      api.database.notificationDao.watchNotEmitted();

  Future<void> createNew(
      {required String title, required String content}) async {
    api.database.notificationDao
        .insertNotification(AppNotificationsCompanion.insert(
      title: Value(title),
      content: Value(content),
      createdAt: DateTime.now(),
    ));

    if (Platform.isWindows) {
      service.show(Toast(
        type: ToastType.text02,
        title: title,
        subtitle: content,
        //actions: ['View'],
      ));
    }
  }

  Future<bool> markAsRead(AppNotification notification) =>
      api.database.notificationDao.markEmitted(notification);*/
}
