import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/utils.dart';

class SidebarLawsuiteListTile extends StatelessWidget {
  final Lawsuite lawsuite;
  final void Function()? onTap;

  const SidebarLawsuiteListTile({Key? key, required this.lawsuite, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TabState>>(
      valueListenable: api.tabHistory,
      builder: (_, tabHistory, __) {
        final selected = api.openTabState is TabState<Lawsuite> &&
            api.openTabState?.id == lawsuite.id;

        return ListTile(
          title: Text(lawsuite.name),
          onTap: onTap,
          leading: IconUtils.lawsuiteIcon(lawsuite.state),
          subtitle: Text('# ${lawsuite.id}'),
          selected: selected,
          selectedTileColor: selected
              ? Theme.of(context).colorScheme.secondary.withAlpha(40)
              : null,
        );
      },
    );
  }
}
