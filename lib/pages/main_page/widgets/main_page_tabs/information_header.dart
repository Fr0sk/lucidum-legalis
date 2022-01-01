import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';

class InformationHeader extends StatelessWidget {
  //final TextEditingController nameController;
  final bool editMode;
  final Widget icon;
  final Widget? child;
  final String? title;
  final void Function()? onEdit;
  final void Function()? onSave;
  final void Function()? onDelete;

  const InformationHeader({
    Key? key,
    //required this.nameController,
    required this.editMode,
    required this.icon,
    this.child,
    this.onEdit,
    this.onSave,
    this.onDelete,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: Row(
        children: [
          if (title != null)
            Text(title!,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.grey, fontStyle: FontStyle.italic)),
          const Spacer(),
          if (editMode)
            IconButton(
              onPressed: onSave,
              icon: AppIcons.save,
              color: Colors.green,
            ),
          if (editMode)
            IconButton(
              onPressed: onDelete,
              icon: AppIcons.delete,
              color: Colors.red[700],
            ),
          IconButton(
            onPressed: onEdit,
            icon: AppIcons.edit,
            color: editMode ? Theme.of(context).colorScheme.secondary : null,
          ),
        ],
      ),
      child: child,
    );
  }
}
