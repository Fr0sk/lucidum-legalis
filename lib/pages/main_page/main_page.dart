import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/notifications_container/notifications_container.dart';
import 'package:lucidum_legalis/pages/main_page/settings_container/settings_container.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_body_client/tab_body_client.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_body_lawsuite/tab_body_lawsuite.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_header.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/notification_badge.dart';
import 'package:lucidum_legalis/widgets/tab_panel.dart';
import 'omnibox/omnibox.dart';
import 'widgets/sidebar/sidebar.dart';

class MainPage extends StatelessWidget {
  final _tabHeaderKey = GlobalKey();
  final _tabBodies = <TabState, Widget>{};
  final _showSettings = ValueNotifier<bool>(false);
  final _showNotifications = ValueNotifier<bool>(false);

  MainPage({Key? key}) : super(key: key) {
    api.tabs.addListener(() {
      // If a new tab was open
      if (api.tabs.length > _tabBodies.length) {
        for (final tab in api.tabs.value) {
          // If the _tabBodies dictionary does not contain this tab
          if (!_tabBodies.keys.contains(tab)) {
            _tabBodies[tab] = _createTabBodyFromState(tab);
          }
        }
        // If a tab was removed
      } else if (api.tabs.length < _tabBodies.length) {
        var idx = 0;
        while (idx < _tabBodies.keys.length) {
          // If the tab in _tabBodies does not exist in the api.tabs
          final tab = _tabBodies.keys.elementAt(idx);
          if (!api.tabs.contains(tab)) {
            _tabBodies.remove(tab);
          } else {
            idx++;
          }
        }
      }
    });
  }

  Widget _createTabBodyFromState(TabState state) {
    if (state is TabState<Client>) {
      return TabBodyClient(state: state);
    } else if (state is TabState<Lawsuite>) {
      return TabBodyLawsuite(state: state);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final omnibox = Omnibox(
      controller: api.omniboxController,
      width: 600,
      height: 500,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            //Text('Welcome {}'.tr(args: [''])),
            const Spacer(),
            ActionChip(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 2,
                label: Row(
                  children: const [
                    AppIcons.search,
                    Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        child: Text('Ctrl'),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        child: Text('F'),
                      ),
                    ),
                  ],
                ),
                onPressed: api.toggleOmnibox),
            const Spacer(),
          ],
        ),
        actions: [
          // Notifications Button
          StreamBuilder<List<AppNotification>>(
            stream: api.database.notificationDao.watchNotEmitted(),
            builder: (_, snapshot) => IconButton(
              onPressed: () =>
                  _showNotifications.value = !_showNotifications.value,
              icon: NotificationBadge(
                icon: AppIcons.notification,
                count: snapshot.data?.length,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showSettings.value = !_showSettings.value,
            icon: ValueListenableBuilder<bool>(
              valueListenable: updaterService.hasUpdates,
              builder: (_, hasUpdates, child) => Badge(
                showBadge: hasUpdates,
                child: child,
              ),
              child: AppIcons.settings,
            ),
          ),
          // Space at the end
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Row(
            children: [
              // Sidebar Spacer
              const SizedBox(width: App.sidebarWidth),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab Headers
                    SizedBox(
                      height: 40,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: Material(
                              elevation: 2,
                              child: Container(),
                            ),
                          ),
                          ValueListenableBuilder<List<TabState>>(
                            valueListenable: api.tabHistory,
                            builder: (context, tabHistory, _) => TabPanel(
                              scrollbarKey: _tabHeaderKey,
                              tabs: api.tabs
                                  .map((t) => TabHeader(tabState: t))
                                  .toList(),
                              selected: tabHistory.isEmpty
                                  ? -1
                                  : api.tabs.indexOf(tabHistory.last),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tab Body
                    Expanded(
                      child: ValueListenableBuilder<List<TabState>>(
                        valueListenable: api.tabHistory,
                        builder: (_, history, __) {
                          if (history.isEmpty) {
                            return Container();
                          }

                          return _tabBodies[history.last] ?? Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Sidebar
          const SizedBox(
            width: App.sidebarWidth,
            child: Material(
              elevation: 10,
              child: Siderbar(),
            ),
          ),
          // Settings Panel

          // Omnibox
          omnibox,

          // Notifications Panel
          ValueListenableBuilder<bool>(
              valueListenable: _showNotifications,
              builder: (_, showNotifications, __) => showNotifications
                  ? NotificationsContainer(
                      width: 300,
                      onDismiss: () => _showNotifications.value = false,
                    )
                  : Container()),

          // Settings Panel
          ValueListenableBuilder<bool>(
              valueListenable: _showSettings,
              builder: (_, showSettings, __) => showSettings
                  ? SettingsContainer(
                      width: 600,
                      onDismiss: () => _showSettings.value = false,
                    )
                  : Container()),
        ],
      ),
    );
  }
}
