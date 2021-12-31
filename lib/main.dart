import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/main_page.dart';
import 'package:lucidum_legalis/services/alert_system.dart.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/services/notification_system.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:window_size/window_size.dart';

late final Api api;
late final AppNotifications appNotifications;
late final AppAlerts appAlerts;

Future<void> main() async {
  // Shows splash screen while app is loading
  //runApp(SplashScreen());

  // Initializes application
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppDirectories.ensureInitialized();
  UserDatabase.setupSqlitePlatformOverrides();

  api = Api();
  appNotifications = AppNotifications();
  appAlerts = AppAlerts();

  // Sets window settings
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(App.title);
    setWindowMinSize(App.windowMinSize);
  }

  // Run the application
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pt', 'PT')],
      fallbackLocale: const Locale('en'),
      path: 'assets/lang/lang.csv',
      assetLoader: CsvAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text('AHAHAHAHAH'),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.grey,
        selectedRowColor: Colors.blue[100],
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MainPage(),
    );
  }
}
