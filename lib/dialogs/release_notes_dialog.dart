import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lucidum_legalis/utils/constants.dart';

class ReleaseNotesDialog {
  static Future<void> show({required BuildContext context}) async {
    var notes = '';

    if (EasyLocalization.of(context)?.currentLocale == Locales.pt) {
      notes = await rootBundle.loadString('assets/release_notes/pt_PT.md');
    } else {
      notes = await rootBundle.loadString('assets/release_notes/en.md');
    }

    late AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      width: 900,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      showCloseIcon: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Markdown(controller: ScrollController(), data: notes),
      ),
    );

    await dialog.show();
  }
}
