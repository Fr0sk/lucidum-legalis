import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'sidebar_controller.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;

class SidebarBottomNavigation extends StatefulWidget {
  final void Function()? onClientsPressed;
  final void Function()? onLawsuitesPressed;
  final SidebarController? controller;
  final Widget bottomMenu;

  const SidebarBottomNavigation(
      {Key? key,
      this.onClientsPressed,
      this.onLawsuitesPressed,
      required this.bottomMenu,
      this.controller})
      : super(key: key);

  @override
  State<SidebarBottomNavigation> createState() =>
      _SidebarBottomNavigationState();
}

class _SidebarBottomNavigationState extends State<SidebarBottomNavigation> {
  var _selectedIndex = 0;

  @override
  void initState() {
    widget.controller?.addOnShowClientListner(() => _onTabSelected(0));
    widget.controller?.addOnShowLawsuiteListner(() => _onTabSelected(1));

    super.initState();
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      widget.onClientsPressed?.call();
    } else {
      widget.onLawsuitesPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: constants.AppIcons.client, label: 'Clients'.tr()),
            BottomNavigationBarItem(
                icon: constants.AppIcons.lawsuit, label: 'Lawsuites'.tr())
          ],
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
        ),
        widget.bottomMenu,
      ],
    );
  }
}
