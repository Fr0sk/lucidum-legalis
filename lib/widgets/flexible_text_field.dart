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
  final bool autofocus;
  final int? minLines;
  final int? maxLines;
  final int flex;

  const FlexibleTextField({
    Key? key,
    this.controller,
    this.labelText = '',
    this.readOnly = false,
    this.numberOnly = false,
    this.decoration,
    this.focusNode,
    this.hintText,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          focusNode: focusNode,
          autofocus: autofocus,
          decoration: decoration ??
              InputDecoration(labelText: labelText, hintText: hintText),
          inputFormatters: numberOnly
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9]+'))]
              : null,
          minLines: minLines,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
