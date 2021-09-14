import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;

class AddMenu extends StatelessWidget {
  final Duration duration;
  final TickerProvider vsync;
  final opened;
  final void Function()? onAddClient;
  final void Function()? onAddLawsuite;

  const AddMenu(
      {Key? key,
      required this.duration,
      required this.vsync,
      required this.opened,
      this.onAddClient,
      this.onAddLawsuite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeOut,
      child: Container(
        height: opened ? null : 0.0,
        child: Column(
          children: [
            ListTile(
              title: Text('Add Client'.tr()),
              leading: constants.AppIcons.addClient,
              onTap: onAddClient,
            ),
            Divider(height: 0),
            ListTile(
              title: Text('Add Lawsuite'.tr()),
              leading: constants.AppIcons.addLawsuite,
              onTap: onAddLawsuite,
            ),
          ],
        ),
      ),
    );
  }
}
