import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/services.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/dialogs/release_notes_dialog.dart';
import 'package:lucidum_legalis/pages/main_page/main_page.dart';
import 'package:lucidum_legalis/services/app_alerts.dart.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/services/app_settings.dart';
import 'package:lucidum_legalis/services/notification_system.dart';
import 'package:lucidum_legalis/services/updater_service.dart';
import 'package:lucidum_legalis/services/window_service.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

late final UserDatabase userDatabase;
late final Api api;
late final AppNotifications appNotifications;
late final AppSettings appSettings;
late final AppAlerts appAlerts;
late final UpdaterService updaterService;

//flutter run -d windows --dart-entrypoint-args showReleaseNotes
Future<void> main(List<String> args) async {
  // Shows splash screen while app is loading
  //runApp(SplashScreen());

  // Initializes application
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await windowManager.ensureInitialized();
  await AppDirectories.ensureInitialized();
  await UserDatabase.backup(databaseDir: AppDirectories.appDocDir);
  UserDatabase.setupSqlitePlatformOverrides();

  userDatabase = UserDatabase(databaseDir: AppDirectories.appDocDir);
  appSettings = AppSettings();
  await appSettings.ensureInitialized();
  api = Api();
  appNotifications = AppNotifications();
  appAlerts = AppAlerts();
  updaterService = UpdaterService();

  // Sets window settings
  windowManager.waitUntilReadyToShow().then((_) async {
    await WindowService().ensureInitialized();
  });

  // Run the application
  runApp(
    EasyLocalization(
      supportedLocales: const [Locales.en, Locales.pt],
      fallbackLocale: const Locale('en'),
      path: 'assets/lang/lang.csv',
      assetLoader: CsvAssetLoader(),
      child: MyApp(
        showReleaseNotes: args.contains('showReleaseNotes'),
      ),
    ),
  );
}

Future<void> restart() async {
  if (updaterService.hasUpdates.value) {
    await updaterService.doUpdate();
  } else {
    final launched = await launch(Platform.resolvedExecutable);
    if (launched) {
      exit(0);
    }
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text(''),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool showReleaseNotes;
  const MyApp({Key? key, this.showReleaseNotes = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (e) {
        if (e.isKeyPressed(LogicalKeyboardKey.keyF) && e.isControlPressed) {
          api.showOmnibox();
        } else if (e.isKeyPressed(LogicalKeyboardKey.escape)) {
          api.closeOmnibox();
        }
      },
      child: MaterialApp(
        title: App.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          shadowColor: Colors.grey,
          selectedRowColor: Colors.blue[100],
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Builder(builder: (context) {
          // Show release notes on startup
          if (showReleaseNotes) {
            WidgetsBinding.instance?.addPostFrameCallback(
                (timeStamp) => ReleaseNotesDialog.show(context: context));
          }

          if (appSettings.saveOpenTabs.value) {
            WidgetsBinding.instance?.addPostFrameCallback(
                (timeStamp) async => await api.loadTabs());
          }

          return MainPage();
        }),
      ),
    );
  }
}
