import 'package:flutter/material.dart';

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
  State<CustomTabs> createState() => _CustomTabsState();
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

    final headers = <Widget>[];
    for (int i = 0; i < widget.headers.length; i++) {
      headers.add(
        Expanded(
          child: TextButton(
              onPressed: () => setState(() => _selectedIndex = i),
              style: TextButton.styleFrom(
                  primary: _selectedIndex == i
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).hintColor),
              child: widget.headers[i]),
        ),
      );
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: widget.bodies[_selectedIndex]),
          Material(elevation: 20, child: Row(children: headers)),
        ],
      ),
    );
  }
}
