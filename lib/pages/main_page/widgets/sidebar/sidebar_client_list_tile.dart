import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
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
          subtitle: IconTheme(
            data: const IconThemeData(size: 20),
            child: StreamBuilder<List<Lawsuite>>(
                stream: userDatabase.clientLawsuiteDao
                    .watchLawsuitesByClientId(client.id),
                builder: (context, snapshot) {
                  var opened = 0;
                  var attention = 0;
                  var waiting = 0;
                  var closed = 0;

                  if (snapshot.hasData) {
                    opened = snapshot.data!
                        .where((l) => l.state == LawsuiteState.open)
                        .length;
                    attention = snapshot.data!
                        .where(
                            (l) => l.state == LawsuiteState.requiresAttention)
                        .length;
                    waiting = snapshot.data!
                        .where((l) => l.state == LawsuiteState.waiting)
                        .length;
                    closed = snapshot.data!
                        .where((l) => l.state == LawsuiteState.closed)
                        .length;
                  }

                  return Row(
                    children: [
                      Tooltip(
                        message: 'Opened'.tr(),
                        child: opened > 0
                            ? AppIcons.lawsuiteOpened
                            : AppIcons.lawsuiteOpenedDisabled,
                      ),
                      Text('$opened',
                          style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      Tooltip(
                        message: 'Requires Attention'.tr(),
                        child: attention > 0
                            ? AppIcons.lawsuiteAttention
                            : AppIcons.lawsuiteAttentionDisabled,
                      ),
                      Text('$attention',
                          style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      Tooltip(
                        message: 'Waiting'.tr(),
                        child: waiting > 0
                            ? AppIcons.lawsuiteWaiting
                            : AppIcons.lawsuiteWaitingDisabled,
                      ),
                      Text('$waiting',
                          style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      Tooltip(
                        message: 'Closed'.tr(),
                        child: closed > 0
                            ? AppIcons.lawsuiteClosed
                            : AppIcons.lawsuiteClosedDisabled,
                      ),
                      Text('$closed',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  );
                }),
          ),
          selected: selected,
          selectedTileColor: selected
              ? Theme.of(context).colorScheme.secondary.withAlpha(40)
              : null,
        );
      },
    );
  }
}
