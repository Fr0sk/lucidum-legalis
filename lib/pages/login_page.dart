import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/services/app_settings.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:lucidum_legalis/utils/builders.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:lucidum_legalis/widgets/login_card.dart';
import 'package:lucidum_legalis/widgets/new_account_card.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final Api api;
  bool _showNewAccount = false;

  @override
  void initState() {
    api = context.read<Api>();
    super.initState();
  }

  Future<void> _onLogin(String username, bool autoLogin) async {
    final result = await api.loadUser(username);

    switch (result) {
      case LoadUserResult.SUCCESS:
        if (autoLogin) {
          AppSettings().savedUser = username;
        } else {
          AppSettings().savedUser = '';
        }
        await AppSettings().save();
        break;
      case LoadUserResult.NOT_FOUND:
        SnackbarBuilder.show(context: context, text: 'Username not found'.tr());
        break;
      case LoadUserResult.ERROR:
        SnackbarBuilder.show(context: context, text: 'Error loading user'.tr());
        break;
      case LoadUserResult.EMPTY_USERNAME:
        SnackbarBuilder.show(context: context, text: 'Invalid username'.tr());
        break;
      default:
    }
  }

  Future<void> _onCreateAccount(String username, String password) async {
    final result = await api.createUser(username, password);

    switch (result) {
      case CreateUserResult.SUCCESS:
        await _onLogin(username, false);
        break;
      case CreateUserResult.ALREADY_EXISTS:
        SnackbarBuilder.show(
            context: context, text: 'Username already exists'.tr());
        break;
      case CreateUserResult.ERROR:
        SnackbarBuilder.show(
            context: context, text: 'Error creating user'.tr());
        break;
      case CreateUserResult.EMPTY_USERNAME:
        SnackbarBuilder.show(context: context, text: 'Invalid username'.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: AutoSizeText(
                    constants.App.Title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: constants.Fonts.Logo(
                        textStyle: Theme.of(context).textTheme.headline1),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: _showNewAccount
                ? NewAccountCard(
                    onCreateAccount: _onCreateAccount,
                    onCancel: () => setState(() {
                      _showNewAccount = false;
                    }),
                  )
                : LoginCard(
                    onLogin: _onLogin,
                    onNewAccount: () => setState(() {
                      _showNewAccount = true;
                    }),
                  ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.setLocale(constants.Locales.Pt);
                },
                child: Text('PT'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.setLocale(constants.Locales.En);
                },
                child: Text('EN'),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
