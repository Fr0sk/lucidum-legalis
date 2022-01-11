import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/tables/alerts.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';

class AppAlerts {
  Timer? _timer;
  final refresh = ValueNotifier<DateTime?>(null);

  AppAlerts() {
    _startTimer();
  }

  Future<void> _startTimer() async {
    _timer?.cancel();

    final now = DateTime.now();
    _timer = Timer(
      Duration(
          minutes: 60 - now.minute - 1,
          seconds: 60 - now.second - 1,
          milliseconds: 100 - now.millisecond),
      () => refresh.value = now,
    );
  }

  Future<List<Alert>> getAll() => api.database.alertDao.getAll();

  Future<List<Alert>> getNotEmitted() => api.database.alertDao.getNotEmitted();

  Future<void> createAlert(
      {required String title,
      required String content,
      required DateTime emitAt,
      required AlertType type}) async {
    await api.database.alertDao.insertAlert(AlertsCompanion.insert(
        title: Value(title),
        content: Value(content),
        emitAt: emitAt,
        type: type,
        createdAt: DateTime.now()));
    await _startTimer();
  }
}
