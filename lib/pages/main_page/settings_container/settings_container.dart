import 'dart:io';

import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';

part 'updater_label.part.dart';

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
                        const Divider(),
                        ListTile(
                          title: Text('Language'.tr()),
                          subtitle: DropdownButton<Locale>(
                            value: context.locale,
                            items: const [
                              DropdownMenuItem(
                                child: Text('English'),
                                value: Locales.en,
                              ),
                              DropdownMenuItem(
                                child: Text('Português'),
                                value: Locales.pt,
                              ),
                            ],
                            onChanged: (newLocale) {
                              if (newLocale != null) {
                                context.setLocale(newLocale);
                              }
                            },
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text('Application'.tr()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable: updater.hasUpdates,
                                      builder: (_, hasUpdates, child) => Badge(
                                        position: const BadgePosition(
                                            top: -5, end: 0),
                                        child: child,
                                        showBadge: hasUpdates,
                                      ),
                                      child: SizedBox(
                                        width: 225,
                                        child: OutlinedButton(
                                          child: Text('Restart'.tr()),
                                          onPressed: () {
                                            restart();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 225,
                                      child: OutlinedButton(
                                        child: Text('Exit'.tr()),
                                        onPressed: () => exit(0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const _UpdaterLabel(),
                            ],
                          ),
                        ),
                        const Divider(),
                        ElevatedButton(
                            onPressed: () async {
                              await updater.checkForUpdates();
                            },
                            child: const Text('Test'))
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
