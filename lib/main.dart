import 'dart:ffi';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:lucidum_legalis/pages/main_page/main_page.dart';
import 'package:lucidum_legalis/services/app_settings.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/open.dart';

void setupSqlitePlatformOverrides() {
  //final script = File(Platform.script.toFilePath());
  open.overrideFor(
      OperatingSystem.linux, () => DynamicLibrary.open('libsqlite.so'));
  open.overrideFor(
      OperatingSystem.windows, () => DynamicLibrary.open('sqlite3.dll'));
}

Future<void> main() async {
  // Shows splash screen while app is loading
  //runApp(SplashScreen());

  // Initializes application
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupSqlitePlatformOverrides();
  await AppSettings().load();

  // Auto loads saved user
  /*if (AppSettings().savedUser.isNotEmpty) {
    await api.loadUser(AppSettings().savedUser);
  }*/

  // Run the application
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('pt', 'PT')],
      fallbackLocale: Locale('en'),
      path: 'assets/lang/lang.csv',
      assetLoader: CsvAssetLoader(),
      child: ChangeNotifierProvider(
        create: (_) => Api(),
        child: MyApp(),
      ),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('AHAHAHAHAH'),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.Title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.grey,
        selectedRowColor: Colors.blue[100],
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MainPage(),
      /*home: Consumer<Api>(
        builder: (context, api, child) {
          if (api.user == null) {
            return LoginPage();
          } else {
            return MainPage();
          }
        },
      ),*/
    );
  }
}
