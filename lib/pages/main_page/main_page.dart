import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_body_client/tab_body_client.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_body_lawsuite/tab_body_lawsuite.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_header.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/tab_panel.dart';
import 'widgets/sidebar/sidebar.dart';

class MainPage extends StatelessWidget {
  final _tabHeaderKey = GlobalKey();
  final _tabBodies = <TabState, Widget>{};

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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome {}'.tr(args: ['Hehehe'])),
            const Spacer(),
            Container(
              color: Colors.red,
              height: 30,
              width: 200,
              child: const Text('[F1] Search'),
            ),
          ],
        ),
        actions: [
          // Settings button
          IconButton(
            onPressed: () {}, //TODO: Implement Settings'
            icon: AppIcons.settings,
          )
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          const SizedBox(
            width: 250,
            child: Material(
              elevation: 5,
              child: Siderbar(),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Headers
                SizedBox(
                  height: 40,
                  child: ValueListenableBuilder<List<TabState>>(
                    valueListenable: api.tabHistory,
                    builder: (context, tabHistory, _) => TabPanel(
                      scrollbarKey: _tabHeaderKey,
                      tabs:
                          api.tabs.map((t) => TabHeader(tabState: t)).toList(),
                      selected: tabHistory.isEmpty
                          ? -1
                          : api.tabs.indexOf(tabHistory.last),
                    ),
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
    );
  }
}
