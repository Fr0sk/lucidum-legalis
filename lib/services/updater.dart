import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lucidum_legalis/data/version.dart';
import 'package:lucidum_legalis/utils/constants.dart';

class Updater {
  final _checkDuration = const Duration(seconds: 20);
  final hasUpdates = ValueNotifier<bool>(false);
  final lastCheck = ValueNotifier<DateTime?>(null);
  final autoUpdater = ValueNotifier<bool>(false);
  Timer? _timer;

  Updater() {
    autoUpdater.addListener(checkForTimer);
    checkForTimer();
  }

  void checkForTimer() {
    if (autoUpdater.value && !hasUpdates.value) {
      // Autoupdate is on
      _timer ??= Timer.periodic(_checkDuration, (_) => checkForUpdates());
    } else {
      // Autoupdate is off
      _timer?.cancel();
      _timer = null;
    }
  }

  Future<bool> checkForUpdates() async {
    if (hasUpdates.value) {
      _timer?.cancel();
      return true;
    }

    const pattern = 'Fr0sk/sample/releases/tag/';
    final url = Uri.parse('https://github.com/Fr0sk/sample/releases/latest');

    final response = await http.get(url);

    lastCheck.value = DateTime.now();
    if (response.statusCode != 200) {
      return false;
    }

    final body = response.body;
    var versionString = body.substring(body.indexOf(pattern) + pattern.length);
    versionString = versionString.substring(0, versionString.indexOf('"'));
    final onlineVersion = Version.parse(versionString);
    if (onlineVersion > App.version) {
      hasUpdates.value = true;
    } else {
      hasUpdates.value = false;
    }

    return hasUpdates.value;
  }
}
