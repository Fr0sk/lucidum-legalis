import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/widgets/password_form_field.dart';

class TextInputDialog {
  static Future<String?> show({
    required BuildContext context,
    required String title,
    String defaultText = '',
    String description = '',
    String? labelText,
  }) async {
    final controller = TextEditingController(text: defaultText);
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
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: TextFormField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(labelText: labelText),
              onFieldSubmitted: (value) {
                result = value;
                dialog.dismiss();
              },
            ),
          )
        ],
      ),
      btnCancelText: 'Cancel'.tr(),
      btnCancelOnPress: () => result = null,
      btnOkText: 'Confirm'.tr(),
      btnOkOnPress: () => result = controller.text,
    );

    await dialog.show();

    return result;
  }
}
