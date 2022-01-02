import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lucidum_legalis/data/version.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import 'app_directories.dart';

class Updater {
  final _checkDuration = const Duration(seconds: 20);
  final hasUpdates = ValueNotifier<bool>(false);
  final lastCheck = ValueNotifier<DateTime?>(null);
  final autoUpdater = ValueNotifier<bool>(false);
  final downloadProgress = ValueNotifier<double?>(null);

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

  // Checks if there is a new version available
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

  // Downloads update and decompresses it into the Update folder
  Future<void> downloadUpdate() async {
    const url =
        'https://github.com/Fr0sk/sample/releases/latest/download/lucidum_legalis_win64.zip';
    int total = 0;
    int received = 0;

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

      //print('Create file at ' + AppDirectories.getUploadFile().path);
      //await AppDirectories.getUploadFile().writeAsBytes(bytes);
      final archive = ZipDecoder().decodeBytes(bytes);
      for (final file in archive) {
        final filename = file.name;

        if (file.isFile) {
          final data = file.content as List<int>;
          final out = File(AppDirectories.getUpdateDir().path + '/' + filename);
          await out.create(recursive: true);
          await out.writeAsBytes(data);
        } else {
          await Directory(AppDirectories.getUpdateDir().path + '/' + filename)
              .create(recursive: true);
        }
      }
      downloadProgress.value = null;
    });
  }

  // Replaces the application files with the ones inside Update folder
  Future<void> doUpdate() async {
    final updateFolder = Directory(p.dirname(Platform.resolvedExecutable));
    final programFolder = updateFolder.parent;
    await Copy.directory(updateFolder, programFolder);

    final appName = p.basename(Platform.resolvedExecutable);
    await launch(p.join(programFolder.path, appName));
    exit(0);
  }

  // Deletes the update folder
  Future<void> cleanupUpdate() async {
    await AppDirectories.getUpdateDir().delete(recursive: true);
  }
}
