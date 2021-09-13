import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucidum_legalis/widgets/password_form_field.dart';

class UnlockDbDialog {
  static Future<String?> show(BuildContext context) async {
    final controller = TextEditingController();
    late AwesomeDialog dialog;
    String? result;

    dialog = AwesomeDialog(
      width: 400,
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Database Locked'.tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Enter the password to unlock the database:'.tr()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: PasswordFormField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(labelText: 'Password'.tr()),
              onFieldSubmitted: (value) {
                result = value;
                dialog.dismiss();
              },
            ),
          )
        ],
      ),
      btnCancelText: 'Leave'.tr(),
      btnCancelOnPress: () => result = null,
      btnOkText: 'Unlock'.tr(),
      btnOkOnPress: () => result = controller.text,
    );

    await dialog.show();

    return result;
  }
}
