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
    return StreamBuilder(
        stream: tabState.data,
        builder: (_, snapshot) {
          if (snapshot.data is Client) {
            final client = snapshot.data as Client?;
            return _TabHeaderButton(
              text: client?.name ?? 'Loading'.tr(),
              icon: AppIcons.client,
              isActive: tabState == api.tabHistory.last,
              onPressed: () =>
                  client == null ? null : api.openClient(id: client.id),
              onClosed: () => api.closeTab(tabState: tabState),
            );
          } else if (snapshot.data is Lawsuite) {
            final lawsuite = snapshot.data as Lawsuite?;
            return _TabHeaderButton(
              text: (snapshot.data as Lawsuite?)?.name ?? 'Loading'.tr(),
              icon: AppIcons.lawsuite,
              isActive: tabState == api.tabHistory.last,
              onPressed: () =>
                  lawsuite == null ? null : api.openLawsuite(id: lawsuite.id),
              onClosed: () => api.closeTab(tabState: tabState),
            );
          } else {
            return _TabHeaderButton(
              text: (snapshot.data as Client?)?.name ?? 'Loading'.tr(),
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
    final content = Row(
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
    );

    return isActive
        ? ElevatedButton.icon(onPressed: onPressed, icon: icon, label: content)
        : TextButton.icon(onPressed: onPressed, icon: icon, label: content);
  }
}
