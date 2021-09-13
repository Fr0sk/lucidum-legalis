import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:lucidum_legalis/widgets/sized_elevated_button.dart';

class LoginCard extends StatefulWidget {
  final void Function(String username, bool loginAutomatically)? onLogin;
  final void Function()? onNewAccount;

  const LoginCard({Key? key, this.onLogin, this.onNewAccount})
      : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _loginAutomatically = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      widget.onLogin?.call(
        _usernameController.text,
        _loginAutomatically,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Title
            Text(
              'Login'.tr(),
              style: constants.Fonts.Logo(
                  textStyle: Theme.of(context).textTheme.headline3),
            ),
            // Username text field
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: TextFormField(
                controller: _usernameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Username'.tr(),
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty == true) {
                    return 'Username is required'.tr();
                  }
                },
                onFieldSubmitted: (_) => _submitForm(),
              ),
            ),
            // Auto login switch
            SwitchListTile(
              title: Text('LoginAutomatically'.tr()),
              value: _loginAutomatically,
              onChanged: (value) {
                setState(() {
                  _loginAutomatically = value;
                });
              },
            ),
            // Login button
            SizedElevatedButton(
              width: constants.Widgets.LargeButtonWidth,
              onPressed: _submitForm,
              child: Text('Login'.tr(), textAlign: TextAlign.center),
            ),
            // New account button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () => widget.onNewAccount?.call(),
                child: Text('NewAccount?'.tr()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
