import 'package:flutter/material.dart';

class FlexibleTextField extends StatelessWidget {
  final int flex;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final TextEditingController controller;

  const FlexibleTextField(
      {Key key, this.flex, this.padding, this.labelText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
      child: Padding(
        padding: padding ?? EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
        ),
      ),
    );
  }
}
