import 'package:lucidum_legalis/generated/i18n.dart';
import 'package:lucidum_legalis/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lucidum_legalis/config/routes/router.gr.dart';

void main() {
  //AppSettingsModel.init().then((value) => print(value.usersPath));

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: CMS(),
    ),
  );
}

class CMS extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;

    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(
        fallback: Locale('en', 'US'),
      ),
    );
  }
}
