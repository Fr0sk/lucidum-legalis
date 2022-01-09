import 'package:flutter/material.dart';

class DynamicTextFieldController<T> extends TextEditingController {
  final int id;
  final T? custom;

  DynamicTextFieldController({required this.id, String? text, this.custom})
      : super(text: text);
}
