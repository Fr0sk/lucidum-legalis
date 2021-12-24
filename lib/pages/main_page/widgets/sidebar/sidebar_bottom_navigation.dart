import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;

class SidebarBottomNavigation extends StatefulWidget {
  final void Function()? onClientsPressed;
  final void Function()? onLawsuitesPressed;
  final Widget bottomMenu;

  const SidebarBottomNavigation(
      {Key? key,
      this.onClientsPressed,
      this.onLawsuitesPressed,
      required this.bottomMenu})
      : super(key: key);

  @override
  _SidebarBottomNavigationState createState() =>
      _SidebarBottomNavigationState();
}

class _SidebarBottomNavigationState extends State<SidebarBottomNavigation> {
  var _selectedIndex = 0;

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
                icon: constants.AppIcons.lawsuite, label: 'Lawsuites'.tr())
          ],
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
        ),
        widget.bottomMenu,
      ],
    );
  }
}