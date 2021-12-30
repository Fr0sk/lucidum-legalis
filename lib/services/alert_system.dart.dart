import 'dart:async';

import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';

class AppAlerts {
  Timer? _timer;

  AppAlerts() {
    _startTimer();
  }

  Future<void> _startTimer() async {
    _timer?.cancel();

    final alerts = await getNotEmitted();
    for (var alert in alerts) {
      if (alert.emitAt.compareTo(DateTime.now()) <= 0) {
        emit(alert);
      } else {
        final delta = alert.emitAt.difference(DateTime.now());
        _timer = Timer(delta, () {
          emit(alert);
          _startTimer();
        });
        break;
      }
    }
  }

  Future<List<Alert>> getAll() => api.database.alertDao.getAll();

  Future<List<Alert>> getNotEmitted() => api.database.alertDao.getNotEmitted();

  Future<void> createAlert(
      {required String title,
      required String content,
      required DateTime emitAt}) async {
    await api.database.alertDao.insertAlert(AlertsCompanion.insert(
      title: Value(title),
      content: Value(content),
      emitAt: emitAt,
    ));
    await _startTimer();
  }

  Future<bool> markAsEmitted(Alert alert) =>
      api.database.alertDao.markEmitted(alert);

  Future<void> emit(Alert alert) async {
    await markAsEmitted(alert);
    await appNotifications.createNew(
        title: alert.title ?? '', content: alert.content ?? '');
  }
}
