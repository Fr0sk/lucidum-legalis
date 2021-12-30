import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';

class SidebarClientListTile extends StatelessWidget {
  final Client client;
  final void Function()? onTap;

  const SidebarClientListTile({Key? key, required this.client, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*final selected = api.openTabStateNotifier is TabState<Client> &&
        api.openTabStateNotifier?.id == client.id;*/

    return ValueListenableBuilder<List<TabState>>(
      valueListenable: api.tabHistory,
      builder: (_, tabHistory, __) {
        final selected = api.openTabState is TabState<Client> &&
            api.openTabState?.id == client.id;

        return ListTile(
          title: Text(client.name),
          onTap: onTap,
          leading: IconUtils.clientIcon(client.type),
          selected: selected,
          selectedTileColor: selected
              ? Theme.of(context).colorScheme.secondary.withAlpha(40)
              : null,
        );
      },
    );
  }
}
