import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:lucidum_legalis/widgets/password_form_field.dart';
import 'package:lucidum_legalis/widgets/sized_elevated_button.dart';

class NewAccountCard extends StatelessWidget {
  final void Function(String username, String password)? onCreateAccount;
  final void Function()? onCancel;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      onCreateAccount?.call(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }

  NewAccountCard({Key? key, this.onCreateAccount, this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            // Title
            Text(
              'CreateAccount'.tr(),
              style: constants.Fonts.Logo(
                  textStyle: Theme.of(context).textTheme.headline3),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Column(
                children: [
                  // Username text field
                  TextFormField(
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
                  // Password text field
                  PasswordFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'PasswordOptional'.tr(),
                    ),
                    onFieldSubmitted: (_) => _submitForm(),
                  ),
                  // Password confirm text field
                  PasswordFormField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                      labelText: 'PasswordConfirmOptional'.tr(),
                    ),
                    validator: (String? value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match'.tr();
                      }
                    },
                    onFieldSubmitted: (_) => _submitForm(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  // Create Account Button
                  SizedElevatedButton(
                    width: constants.Widgets.LargeButtonWidth,
                    onPressed: _submitForm,
                    child:
                        Text('CreateAccount'.tr(), textAlign: TextAlign.center),
                  ),
                  Spacer(),
                  // Cancel Button
                  SizedElevatedButton(
                    width: constants.Widgets.LargeButtonWidth,
                    onPressed: onCancel,
                    child: Text('Cancel'.tr(), textAlign: TextAlign.center),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
