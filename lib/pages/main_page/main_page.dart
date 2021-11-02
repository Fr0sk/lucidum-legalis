import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/tab_header.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:provider/provider.dart';
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
            Spacer(),
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
              child: Text('[F1] Search'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => print('TODO: Implement Settings'),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: Material(
              elevation: 5,
              child: Siderbar(),
            ),
          ),
          Expanded(
            child: Consumer<Api>(
              builder: (_, api, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab Headers
                    SizedBox(
                      height: 40,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse
                            }),
                        child: Scrollbar(
                          controller: _headerScrollController,
                          isAlwaysShown: true,
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: api.tabs.length,
                            controller: _headerScrollController,
                            itemBuilder: (_, idx) =>
                                TabHeader(tabState: api.tabs[idx]),
                          ),
                        ),
                      ),
                    ),
                    // Current selected tab body
                    Expanded(
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
