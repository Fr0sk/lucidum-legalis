import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/data/user.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/dialogs/unlock_db_dialog.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:lucidum_legalis/utils/builders.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'widgets/main_page_tabs/tab_body_client.dart';
import 'widgets/sidebar/sidebar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final Api _api;
  late final User _user;
  var _loading = true;

  @override
  void initState() {
    () async {
      _api = context.read<Api>();
      _user = _api.user!;

      var unlocked = await _user.db.unlock(_user.password);

      while (!unlocked) {
        if (_user.password.isNotEmpty) {
          SnackbarBuilder.show(
              context: context,
              text: 'Incorrect Password, please try again'.tr());
        }

        final result = await UnlockDbDialog.show(context);
        await Future.delayed(Duration(milliseconds: 500));
        if (result == null) {
          await context.read<Api>().unloadUser();
          return;
        }

        _user.password = result;
        unlocked = await _user.db.unlock(_user.password);
      }

      setState(() {
        _loading = false;
      });
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Welcome {}'.tr(args: [_user.name])),
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
            onPressed: () => _api.unloadUser(),
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
            child: Selector<Api, TabState?>(
              selector: (_, api) => api.openTabState,
              builder: (_, tabState, _child) {
                if (tabState == null) {
                  return Container();
                }
                if (tabState is TabState<Client>) {
                  return ChangeNotifierProvider.value(
                    value: tabState,
                    child: TabBodyClient(tabState),
                  );
                }
                return Container(color: Colors.red);
              },
            ),
          ),
        ],
      ),
    );
  }
}
