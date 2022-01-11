import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';

import 'omnibox_controller.dart';

part 'omnibox_chip.part.dart';

class Omnibox extends StatelessWidget {
  final OmniboxController controller;
  final double width;
  final double height;
  final _focusNode = FocusNode();

  Omnibox({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.visibility,
      builder: (_, isVisible, __) {
        if (!isVisible) {
          return Container();
        }

        controller.searchFilter.value = '';
        return SizedBox.expand(
          child: Container(
            color: AppColors.backdropColor,
            child: Row(
              children: [
                // Left Dismiss Area
                Expanded(
                  child: InkWell(
                    hoverColor: const Color.fromARGB(0, 0, 0, 0),
                    onTap: controller.hide,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: Card(
                        elevation: 8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              /*child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (e) {
                              // DONT FORGET TO ESC -> Close Omnibox too
                              if (e.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                                selected.value = selected.value + 1;
                              }
                            },*/
                              child: ValueListenableBuilder<String>(
                                valueListenable: controller.hintText,
                                builder: (_, hint, __) => TextField(
                                  decoration: InputDecoration(
                                    hintText: hint,
                                  ),
                                  focusNode: _focusNode..requestFocus(),
                                  onChanged: (filter) =>
                                      controller.searchFilter.value = filter,
                                ),
                              ),
                              //),
                            ),
                            Flexible(
                              child: ValueListenableBuilder<List<Widget>>(
                                valueListenable: controller.searchResults,
                                builder: (_, widgets, __) => ListView.builder(
                                  controller: ScrollController(),
                                  itemCount: widgets.length,
                                  itemBuilder: (_, idx) => widgets[idx],
                                ),
                              ),
                            ),
                            const Divider(
                              indent: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  _OmniboxChip(
                                    valueListenable: controller.searchClients,
                                    canToggleListenable:
                                        controller.allowClients,
                                    avatar: AppIcons.client,
                                    label: Text('Clients'.tr()),
                                    onPressed: () {
                                      controller.toggleSearchClients();
                                      _focusNode.requestFocus();
                                    },
                                  ),
                                  const Spacer(),
                                  _OmniboxChip(
                                    valueListenable: controller.searchLawsuites,
                                    canToggleListenable:
                                        controller.allowLawsuites,
                                    avatar: AppIcons.lawsuite,
                                    label: Text('Lawsuites'.tr()),
                                    onPressed: () {
                                      controller.toggleSearchLawsuites();
                                      _focusNode.requestFocus();
                                    },
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom dismiss area
                    Flexible(
                      child: SizedBox(
                        width: width,
                        child: InkWell(
                          hoverColor: const Color.fromARGB(0, 0, 0, 0),
                          onTap: controller.hide,
                        ),
                      ),
                    ),
                  ],
                ),
                // Right dismiss area
                Expanded(
                  child: InkWell(
                    hoverColor: const Color.fromARGB(0, 0, 0, 0),
                    onTap: controller.hide,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
