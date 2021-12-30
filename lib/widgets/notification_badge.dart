import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final Widget icon;
  final int? count;
  final int maxCount;
  final bool showBadge;
  const NotificationBadge({
    Key? key,
    required this.icon,
    this.count,
    this.maxCount = 99,
    this.showBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count == null) {
      return Badge(
        child: icon,
        showBadge: showBadge,
      );
    }

    return Badge(
      position: const BadgePosition(top: -12, end: -5),
      shape: BadgeShape.square,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      borderRadius: BorderRadius.circular(18),
      showBadge: showBadge || (count != null && count! > 0),
      badgeContent: count == null
          ? null
          : Text(
              count! > maxCount ? '$maxCount+' : count.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
      child: icon,
    );
  }
}
