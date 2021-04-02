import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucidum_legalis/constants/app_icons.dart';
import 'package:lucidum_legalis/generated/i18n.dart';

class RegisterForm extends StatefulWidget {
  final void Function(String username, String password) onRegisterPressed;
  final void Function() onCancelPressed;

  const RegisterForm({Key key, this.onCancelPressed, this.onRegisterPressed})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;

  bool get showCreateButton =>
      usernameController.text.isNotEmpty &&
      passwordController.text == passwordConfirmController.text;

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
              i18n.loginCreateAccount,
              style: GoogleFonts.lobsterTwo(fontSize: 42),
            ),

            /**
             * Username field
             */
            TextField(
              controller: usernameController,
              autofocus: true,
              decoration: InputDecoration(hintText: i18n.loginUsername),
              onSubmitted: (text) {
                if (showCreateButton && widget.onRegisterPressed != null) {
                  widget.onRegisterPressed(
                      usernameController.text, passwordController.text);
                }
              },
              onChanged: (_) => setState(() {}),
            ),

            /**
             * Password field
             */
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: i18n.loginPasswordOptional,
                suffixIcon: InkWell(
                  onTap: () => setState(() => showPassword = !showPassword),
                  child: Icon(showPassword ? AppIcons.EYE : AppIcons.EYE_OFF),
                ),
              ),
              obscureText: !showPassword,
              enableSuggestions: false,
              autocorrect: false,
              onSubmitted: (text) {
                if (showCreateButton && widget.onRegisterPressed != null) {
                  widget.onRegisterPressed(
                      usernameController.text, passwordController.text);
                }
              },
              onChanged: (_) => setState(() {}),
            ),

            /**
             * Password confirm field
             */
            TextField(
              controller: passwordConfirmController,
              decoration: InputDecoration(
                hintText: i18n.loginPasswordConfirm,
                suffixIcon: InkWell(
                  onTap: () => setState(
                      () => showConfirmPassword = !showConfirmPassword),
                  child: Icon(
                      showConfirmPassword ? AppIcons.EYE : AppIcons.EYE_OFF),
                ),
              ),
              obscureText: !showConfirmPassword,
              enableSuggestions: false,
              autocorrect: false,
              onSubmitted: (text) {
                if (showCreateButton && widget.onRegisterPressed != null) {
                  widget.onRegisterPressed(
                      usernameController.text, passwordController.text);
                }
              },
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /**
                 * Register button
                 */
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: showCreateButton
                      ? () => widget.onRegisterPressed(
                          usernameController.text, passwordController.text)
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
