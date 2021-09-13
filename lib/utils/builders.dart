import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SnackbarBuilder {
  static void show({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).cardColor,
      content: Row(
        children: [
          Icon(Icons.info_outline, color: Theme.of(context).accentColor),
          SizedBox(width: 8),
          Text(text, style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
      action: SnackBarAction(
        onPressed: () {},
        label: 'X'.tr(),
      ),
    ));
  }
}
