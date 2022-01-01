import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlexibleTextField extends StatelessWidget {
  final bool readOnly;
  final String labelText;
  final bool numberOnly;
  final String? hintText;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final FocusNode? focusNode;

  const FlexibleTextField(
      {Key? key,
      this.controller,
      this.labelText = '',
      this.readOnly = false,
      this.numberOnly = false,
      this.decoration,
      this.focusNode,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          focusNode: focusNode,
          decoration: decoration ??
              InputDecoration(labelText: labelText, hintText: hintText),
          inputFormatters: numberOnly
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9]+'))]
              : null,
        ),
      ),
    );
  }
}
