import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucidum_legalis/constants/app_icons.dart';
import 'package:lucidum_legalis/generated/i18n.dart';

class PasswordForm extends StatefulWidget {
  final void Function(String username) onLoginPressed;
  final void Function() onCancelPressed;
  final String username;

  PasswordForm(
      {Key key, this.onLoginPressed, this.onCancelPressed, this.username})
      : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final passwordController = TextEditingController();
  bool showPassword = false;
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
              i18n.loginHelloUsername(widget.username),
              style: GoogleFonts.lobsterTwo(fontSize: 42),
            ),

            /**
             * Password Field
             */
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              enableSuggestions: false,
              autofocus: true,
              decoration: InputDecoration(
                hintText: i18n.loginPassword,
                suffixIcon: InkWell(
                  onTap: () => setState(() => showPassword = !showPassword),
                  child: Icon(showPassword ? AppIcons.EYE : AppIcons.EYE_OFF),
                ),
              ),
              onSubmitted: (text) {
                if (enableLogin && widget.onLoginPressed != null) {
                  widget.onLoginPressed(text);
                }
              },
              onChanged: (text) =>
                  setState(() => enableLogin = text.isNotEmpty),
              autocorrect: false,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /**
                 * Login button
                 */
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: enableLogin
                      ? () => widget.onLoginPressed(passwordController.text)
                      : null,
                  child: Text(i18n.loginConfirm),
                ),
                SizedBox(
                  width: 10,
                ),

                /**
                 * Cancel button
                 */
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: widget.onCancelPressed,
                  child: Text(i18n.loginCancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
