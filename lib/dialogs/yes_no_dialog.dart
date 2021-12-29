import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class YesNoDialog {
  static Future<bool> show({
    required BuildContext context,
    required String title,
    String description = '',
  }) async {
    late AwesomeDialog dialog;
    bool result = false;

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
        ],
      ),
      btnCancelText: 'No'.tr(),
      btnCancelOnPress: () => result = false,
      btnOkText: 'Yes'.tr(),
      btnOkOnPress: () => result = true,
    );

    await dialog.show();

    return result;
  }
}
