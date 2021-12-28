import 'package:flutter/material.dart';

class TitledCard extends StatelessWidget {
  final String titleText;
  final Widget? title;
  final Widget? child;

  const TitledCard({Key? key, this.titleText = '', this.title, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title ??
                Text(titleText, style: Theme.of(context).textTheme.headline6),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
