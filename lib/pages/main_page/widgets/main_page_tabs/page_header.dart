import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final Widget icon;
  final Widget label;

  const PageHeader({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [icon, label]),
            ),
          ),
        ),
      ],
    );
  }
}
