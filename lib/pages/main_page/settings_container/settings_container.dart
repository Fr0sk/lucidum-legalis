import 'dart:io';

import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/dialogs/release_notes_dialog.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';

part 'updater_label.part.dart';
part 'list_tile_application.part.dart';
part 'list_tile_language.part.dart';

class SettingsContainer extends StatelessWidget {
  final double width;
  final void Function()? onDismiss;

  const SettingsContainer({Key? key, this.onDismiss, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(100, 0, 0, 0),
        ),
        Row(
          children: [
            // Dismissable area
            Expanded(
              child: InkWell(
                hoverColor: const Color.fromARGB(0, 0, 0, 0),
                onTap: onDismiss,
              ),
            ),

            // Settings panel
            SizedBox(
              width: width,
              child: TitledCard(
                titleText: 'Settings'.tr(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Divider(),
                        _ListTileLanguage(),
                        Divider(),
                        _ListTileApplication(),
                        Divider(),
                        ElevatedButton(
                          onPressed: () =>
                              ReleaseNotesDialog.show(context: context),
                          child: Text('Release Notes'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
