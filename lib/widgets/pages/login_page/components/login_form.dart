import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucidum_legalis/generated/i18n.dart';

class LoginForm extends StatefulWidget {
  final void Function(String username, bool autoLogin) onLoginPressed;
  final void Function() onRegisterPressed;

  LoginForm({Key key, this.onLoginPressed, this.onRegisterPressed})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool autoLogin = false;
  bool enableLogin = false;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context);

    return Card(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            /**
             * Title
             */
            Text(
              i18n.loginLogin,
              style: GoogleFonts.lobsterTwo(fontSize: 42),
            ),

            /**
             * Username Field
             */
            TextField(
                controller: usernameController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: i18n.loginUsername,
                ),
                onSubmitted: (text) {
                  if (enableLogin && widget.onLoginPressed != null) {
                    widget.onLoginPressed(text, autoLogin);
                  }
                },
                onChanged: (text) =>
                    setState(() => enableLogin = text.isNotEmpty)),

            /**
             * Auto login Switch
             */
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
              child: SwitchListTile(
                title: Text(i18n.loginAutoLogin),
                value: autoLogin,
                onChanged: (v) => setState(() => autoLogin = v),
              ),
            ),

            /**
             * Login Button
             */
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: enableLogin
                  ? () =>
                      widget.onLoginPressed(usernameController.text, autoLogin)
                  : null,
              child: Text(i18n.loginLogin),
            ),

            /**
             * Create new account button
             */
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
              onPressed: widget.onRegisterPressed,
              child: Text(i18n.loginNewAccount),
            ),
          ],
        ),
      ),
    );
  }
}
