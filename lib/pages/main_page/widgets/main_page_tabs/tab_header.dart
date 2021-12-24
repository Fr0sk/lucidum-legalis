import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';

class TabHeader extends StatelessWidget {
  final TabState<dynamic> tabState;
  final bool isActive;

  const TabHeader({Key? key, required this.tabState, this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: tabState.dataNotifier,
        builder: (_, data, __) {
          if (data is Client) {
            final client = data;
            return _TabHeaderButton(
              text: client.name,
              icon: AppIcons.client,
              isActive: tabState == api.tabHistory.last,
              onPressed: () => api.openClient(id: client.id),
              onClosed: () => api.closeTab(tabState: tabState),
            );
          } else if (data is Lawsuite) {
            final lawsuite = data;
            return _TabHeaderButton(
              text: lawsuite.name,
              icon: AppIcons.lawsuite,
              isActive: tabState == api.tabHistory.last,
              onPressed: () => api.openLawsuite(id: lawsuite.id),
              onClosed: () => api.closeTab(tabState: tabState),
            );
          } else {
            return _TabHeaderButton(
              text: 'Loading'.tr(),
              icon: AppIcons.loading,
              isActive: tabState == api.tabHistory.last,
              onClosed: () => api.closeTab(tabState: tabState),
            );
          }
        });
  }
}

class _TabHeaderButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool isActive;
  final Function()? onPressed;
  final Function()? onClosed;

  const _TabHeaderButton(
      {Key? key,
      required this.text,
      required this.icon,
      this.onPressed,
      this.isActive = false,
      this.onClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(text),
          InkWell(
            onTap: onClosed,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: AppIcons.close,
            ),
          ),
        ],
      ),
    );

    return isActive
        ? ElevatedButton.icon(onPressed: onPressed, icon: icon, label: content)
        : TextButton.icon(onPressed: onPressed, icon: icon, label: content);
  }
}