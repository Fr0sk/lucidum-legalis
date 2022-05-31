import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lucidum_legalis/data/version.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:path/path.dart' as p;

class UpdaterService {
  /// Creates the updater service for the corresponding platform
  final _checkDuration = const Duration(hours: 1);
  final hasUpdates = ValueNotifier<bool>(false);
  final lastCheck = ValueNotifier<DateTime?>(null);
  final downloadProgress = ValueNotifier<double?>(null);

  Timer? _timer;

  UpdaterService() {
    // If auto check for updates is enabled, check on startup
    if (appSettings.checkForUpdates.value) {
      Future.delayed(const Duration(seconds: 2)).then((_) => checkForUpdates());
    }

    // Start background timer to check for updates
    _timer = Timer.periodic(_checkDuration, (_) {
      if (appSettings.checkForUpdates.value) {
        checkForUpdates();
      }
    });
  }

  /// Checks if there is a new version available
  Future<bool> checkForUpdates() async {
    if (hasUpdates.value) {
      _timer?.cancel();
      downloadProgress.value = null;
      return true;
    }

    downloadProgress.value = -1;

    const pattern = 'Fr0sk/lucidum-legalis/releases/tag/';
    final url =
        Uri.parse('https://github.com/Fr0sk/lucidum-legalis/releases/latest');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      downloadProgress.value = null;
      return false;
    }

    final body = response.body;
    var versionString = body.substring(body.indexOf(pattern) + pattern.length);
    versionString = versionString.substring(0, versionString.indexOf('"'));
    final onlineVersion = Version.parse(versionString);

    if (onlineVersion > App.version) {
      await downloadUpdate();
      hasUpdates.value = true;
      _timer?.cancel();
    } else {
      hasUpdates.value = false;
    }

    lastCheck.value = DateTime.now();
    downloadProgress.value = null;
    return hasUpdates.value;
  }

  /// Downloads update and decompresses it into the Update folder
  Future<void> downloadUpdate() async {
    final url = Platform.isWindows
        ? 'https://github.com/Fr0sk/lucidum-legalis/releases/latest/download/lucidum_legalis_win64.zip'
        : throw 'Platform not supported';

    int total = 0;
    int received = 0;
    final completer = Completer();
    final bytes = <int>[];

    final response =
        await http.Client().send(http.Request('GET', Uri.parse(url)));
    total = response.contentLength ?? 0;

    response.stream.listen((value) {
      bytes.addAll(value);
      received += value.length;
      downloadProgress.value = received / total;
    }).onDone(() async {
      downloadProgress.value = -1;

      await AppDirectories.updatePakage.writeAsBytes(bytes);

      // Checks if there is an updater program in the package,
      // and if it extract it
      final archive = ZipDecoder().decodeBytes(bytes);
      for (final file in archive) {
        if (file.isFile &&
            file.name == p.basename(AppDirectories.updater.path)) {
          final out = File(file.name);
          await out.create(recursive: true);
          await out.writeAsBytes(file.content);
          break;
        }
      }

      downloadProgress.value = null;
      completer.complete();
    });

    await completer.future;
  }

  /// Replaces the application files with the ones inside Update folder
  Future<void> doUpdate() async {
    if (await AppDirectories.updater.exists()) {
      await Process.start(AppDirectories.updater.path, [],
          mode: ProcessStartMode.detached, runInShell: true);
      exit(0);
    }
  }

  /// Deletes the update package if it exists
  /*Future<void> cleanupUpdate() async {
    if (await AppDirectories.updatePakage.exists()) {
      await AppDirectories.updatePakage.delete();
    }
  }*/
}
