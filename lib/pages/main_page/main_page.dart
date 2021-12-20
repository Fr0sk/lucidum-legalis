import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/tab_panel.dart';
import 'widgets/sidebar/sidebar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _headerScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome {}'.tr(args: ['Hehehe'])),
            const Spacer(),
            /*Selector<Api, TabState?>(
                builder: (_, tabState, __) {
                  if (tabState == null) {
                    return Container();
                  }

                  return StreamBuilder(
                    stream: tabState.data,
                    builder: (_, snapshot) {
                      if (snapshot.data is Client) {
                        final client = snapshot.data as Client;
                        return Row(
                          children: [
                            constants.AppIcons.client,
                            Text(client.name),
                          ],
                        );
                      } else if (snapshot.data is Lawsuite) {
                        final lawsuite = snapshot.data as Lawsuite;
                        return Row(
                          children: [
                            constants.AppIcons.lawsuite,
                            Text(lawsuite.name)
                          ],
                        );
                      }
                      return Container();
                    },
                  );
                },
                selector: (_, api) => api.openTabState),
            Spacer(),*/
            Container(
              color: Colors.red,
              height: 30,
              width: 200,
              child: const Text('[F1] Search'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {}, //TODO: Implement Settings'
            icon: AppIcons.settings,
          )
        ],
      ),
      body: Row(
        children: [
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
                  child: TabPanel(
                    tabs: const [],
                  ),

                  /*ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse
                        }),
                    child: Scrollbar(
                      controller: _headerScrollController,
                      isAlwaysShown: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: api.tabs.length,
                        controller: _headerScrollController,
                        itemBuilder: (_, idx) =>
                            TabHeader(tabState: api.tabs[idx]),
                      ),
                    ),
                  ),*/
                ),
                // Current selected tab body
                Expanded(
                  child: Container(
                    color: Colors.red,
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
