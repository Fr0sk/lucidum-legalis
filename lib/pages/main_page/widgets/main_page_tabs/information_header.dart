import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';

class InformationHeader extends StatelessWidget {
  final TextEditingController nameController;
  final bool readOnly;
  final Widget icon;
  final void Function()? onEdit;
  final void Function()? onSave;
  final void Function()? onDelete;

  const InformationHeader({
    Key? key,
    required this.nameController,
    required this.readOnly,
    required this.icon,
    this.onEdit,
    this.onSave,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                  controller: nameController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Name'.tr()),
                ),
              ),
            ),
            const Spacer(),
            readOnly
                ? Container()
                : IconButton(
                    onPressed: onSave,
                    icon: AppIcons.save,
                    color: Colors.green,
                  ),
            readOnly
                ? Container()
                : IconButton(
                    onPressed: onDelete,
                    icon: AppIcons.delete,
                    color: Colors.red[700],
                  ),
            IconButton(
              onPressed: onEdit,
              icon: AppIcons.edit,
              color: readOnly ? null : Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
