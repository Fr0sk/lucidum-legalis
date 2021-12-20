import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;

class SidebarLawsuiteListTile extends StatelessWidget {
  final Lawsuite lawsuite;
  final void Function()? onTap;

  const SidebarLawsuiteListTile({Key? key, required this.lawsuite, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = api.openTabStateNotifier.value is TabState<Lawsuite> &&
        api.openTabStateNotifier.value?.id == lawsuite.id;

    return ListTile(
      title: Text(lawsuite.name),
      onTap: onTap,
      leading: constants.AppIcons.lawsuite,
      selected: selected,
      selectedTileColor: selected
          ? Theme.of(context).colorScheme.secondary.withAlpha(40)
          : null,
    );
  }
}
