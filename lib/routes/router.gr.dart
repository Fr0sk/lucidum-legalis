// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i4;

import '../widgets/pages/login_page/login_page.dart' as _i2;
import '../widgets/pages/main_page/main_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoginPageRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<LoginPageRouteArgs>(orElse: () => LoginPageRouteArgs());
      return _i1.MaterialPageX(
          entry: entry,
          child: _i2.LoginPage(key: args.key),
          maintainState: true,
          fullscreenDialog: false);
    },
    MainPageRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<MainPageRouteArgs>(orElse: () => MainPageRouteArgs());
      return _i1.MaterialPageX(
          entry: entry,
          child: _i3.MainPage(key: args.key),
          maintainState: true,
          fullscreenDialog: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LoginPageRoute.name,
            path: '/', fullMatch: false, usesTabsRouter: false),
        _i1.RouteConfig(MainPageRoute.name,
            path: '/main-page', fullMatch: false, usesTabsRouter: false)
      ];
}

class LoginPageRoute extends _i1.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({this.key})
      : super(name, path: '/', args: LoginPageRouteArgs(key: key));

  final _i4.Key key;

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key});

  final _i4.Key key;
}

class MainPageRoute extends _i1.PageRouteInfo<MainPageRouteArgs> {
  MainPageRoute({this.key})
      : super(name, path: '/main-page', args: MainPageRouteArgs(key: key));

  final _i4.Key key;

  static const String name = 'MainPageRoute';
}

class MainPageRouteArgs {
  const MainPageRouteArgs({this.key});

  final _i4.Key key;
}
