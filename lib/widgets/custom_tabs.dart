import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucidum_legalis/widgets/button_group.dart';

class CustomTabs extends StatefulWidget {
  final List<Widget> bodies;
  final List<Widget> headers;
  final int? startIndex;
  final double? headerHeight;
  final void Function(int index)? onTabChanged;

  const CustomTabs(
      {Key? key,
      required this.headers,
      required this.bodies,
      this.startIndex,
      this.onTabChanged,
      this.headerHeight})
      : super(key: key);

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.startIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.bodies.length == widget.headers.length);

    return Expanded(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ButtonGroup(
              radioMode: true,
              height: widget.headerHeight,
              initialSelected: widget.startIndex ?? 0,
              onPressed: (index, _) => setState(() => _selectedIndex = index),
              children: widget.headers,
            ),
            Expanded(child: widget.bodies[_selectedIndex])
          ],
        ),
      ),
    );
  }
}
