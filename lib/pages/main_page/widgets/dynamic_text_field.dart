import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/flexible_text_field.dart';

class DynamicTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool readOnly;
  final String? deleteTooltip;
  final void Function()? onDelete;

  const DynamicTextField({
    Key? key,
    this.onDelete,
    this.controller,
    this.label = '',
    this.readOnly = false,
    this.deleteTooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          FlexibleTextField(
            controller: controller,
            labelText: label,
            readOnly: readOnly,
          ),
          if (!readOnly)
            IconButton(
              onPressed: onDelete,
              icon: AppIcons.delete,
              tooltip: deleteTooltip,
            ),
        ],
      ),
    );
  }
}
