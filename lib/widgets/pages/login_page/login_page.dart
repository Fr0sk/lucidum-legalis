import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucidum_legalis/config/routes/router.gr.dart';
import 'package:lucidum_legalis/models/app_model.dart';
import 'package:lucidum_legalis/utils/helpers/user_helper.dart';
import 'package:lucidum_legalis/utils/services/settings_storage_service.dart';
import 'package:lucidum_legalis/widgets/pages/login_page/components/login_form.dart';
import 'package:lucidum_legalis/widgets/pages/login_page/components/password_form.dart';
import 'package:lucidum_legalis/widgets/pages/login_page/components/register_form.dart';
import 'package:provider/provider.dart';

enum _Form { Login, Password, Register }

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textController = TextEditingController();
  //String username;
  _Form _currentForm = _Form.Login;
  String _username;
  bool _loading = false;
  bool _autoLogin = false;

  @override
  void initState() {
    super.initState();

    SettingsStorageService().rememberedUser.then((user) {
      if (user != null) {
        onLoginPressed(user, true);
      }
    });
  }

  void onLoginPressed(String username, bool autoLogin) async {
    setState(() => _loading = true);
    _username = username;
    _autoLogin = autoLogin;

    var appModel = context.read<AppModel>();
    var result = await appModel.loadUser(username: username);

    switch (result) {
      case LoadUserStatus.UserNotFound:
        // TODO user does not exist message
        print('TODO user does not exist');
        setState(() => _loading = false);
        break;
      case LoadUserStatus.WrongPassword:
        await SettingsStorageService()
            .setRememberedUser(_autoLogin ? username : null);
        _showForm(_Form.Password);
        break;
      case LoadUserStatus.Ok:
        await SettingsStorageService()
            .setRememberedUser(_autoLogin ? username : null);

        await _onLoginSuccess();
        break;
    }
  }

  void onPasswordEntered(String password) async {
    setState(() => _loading = true);

    var appModel = context.read<AppModel>();
    var result =
        await appModel.loadUser(username: _username, password: password);

    switch (result) {
      case LoadUserStatus.UserNotFound:
        _showForm(_Form.Login);
        break;
      case LoadUserStatus.WrongPassword:
        // TODO show status message wrong password
        print('Wrong password');
        break;
      case LoadUserStatus.Ok:
        await _onLoginSuccess();
        break;
    }
  }

  void onCreateNewAccountPressed(String username, String password) async {
    setState(() => _loading = true);

    if (password.isNotEmpty) {
      password = Crypt.sha256(password).toString();
    }

    var created = await UserHelper.createNewAccount(username, password);

    if (created) {
      var appModel = context.read<AppModel>();
      var result =
          await appModel.loadUser(username: username, password: password);

      if (result == LoadUserStatus.Ok) {
        await _onLoginSuccess();
      } else {
        print(result);
        // TODO failed to create
        print('Failed to login new user, try again');
      }
    } else {
      // TODO send notification why failed
      print('Failed to create: $username');
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _onLoginSuccess() async {
    await AutoRouter.of(context).navigate(MainPageRoute());
    await Future.delayed(Duration(milliseconds: 250));
    _showForm(_Form.Login);
  }

  void _showForm(_Form form) {
    FocusScope.of(context).unfocus();
    //FocusScope.of(context).requestFocus(null);

    setState(() {
      _loading = false;
      _currentForm = form;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Lucidum\nLegalis',
            style: GoogleFonts.lobsterTwo(
                fontSize: 82, color: Theme.of(context).accentColor),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              constraints: BoxConstraints(maxWidth: 380, minHeight: 350),
              child: PageTransitionSwitcher(
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.scaled,
                      child: child);
                },
                child: _currentForm == _Form.Login
                    ? LoginForm(
                        onLoginPressed: onLoginPressed,
                        onRegisterPressed: () => _showForm(_Form.Register),
                      )
                    : _currentForm == _Form.Password
                        ? PasswordForm(
                            username: _username,
                            onLoginPressed: onPasswordEntered,
                            onCancelPressed: () => _showForm(_Form.Login))
                        : RegisterForm(
                            onCancelPressed: () => _showForm(_Form.Login),
                            onRegisterPressed: onCreateNewAccountPressed,
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
