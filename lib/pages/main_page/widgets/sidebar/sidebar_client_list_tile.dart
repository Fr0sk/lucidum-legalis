import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class SidebarClientListTile extends StatelessWidget {
  final Client client;
  final void Function()? onTap;

  const SidebarClientListTile({Key? key, required this.client, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Api, TabState?>(
      selector: (_, api) => api.openTabState,
      builder: (_, tabState, _child) {
        final selected =
            tabState is TabState<Client> && tabState.id == client.id;

        return ListTile(
          title: Text(client.name),
          onTap: onTap,
          leading: constants.AppIcons.client,
          selected: selected,
          selectedTileColor: selected
              ? Theme.of(context).colorScheme.secondary.withAlpha(40)
              : null,
        );
      },
    );
  }
}
