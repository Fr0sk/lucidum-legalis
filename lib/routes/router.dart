import 'package:auto_route/auto_route.dart';
import 'package:lucidum_legalis/widgets/pages/login_page/login_page.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/main_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: MainPage),
  ],
)
class $AppRouter {}
