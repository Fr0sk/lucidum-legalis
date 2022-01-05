part of 'tab_body_lawsuite.dart';

class _AgainstTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool readOnly;
  final String? deleteTooltip;
  final void Function()? onDelete;

  const _AgainstTextField({
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
