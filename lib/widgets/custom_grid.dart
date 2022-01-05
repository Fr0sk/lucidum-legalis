import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final List<Widget> children;
  final int columns;

  const CustomGrid({Key? key, required this.columns, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    var currentRow = <Widget>[];

    for (var child in children) {
      if (currentRow.length % columns == 0) {
        if (currentRow.isNotEmpty) {
          rows.add(Row(children: currentRow));
          currentRow = [];
        }
      }
      currentRow.add(child);
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(children: currentRow));
    }

    return Column(children: rows);
  }
}
