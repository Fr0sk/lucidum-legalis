import 'package:flutter/foundation.dart';

class Logger {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;
  Logger._internal();

  static void log(
      {required String key, required String type, required String message}) {
    if (kDebugMode) {
      print('[$key] [$type] $message');
    }
  }

  static void debug({required String key, required String message}) =>
      log(key: key, type: 'DEBUG', message: message);

  static void error({required String key, required String message}) =>
      log(key: key, type: 'ERROR', message: message);

  static void warn({required String key, required String message}) =>
      log(key: key, type: 'WARN', message: message);

  static void info({required String key, required String message}) =>
      log(key: key, type: 'INFO', message: message);
}
