import 'package:lucidum_legalis/constants/app_constants.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/main_page_body.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/main_page_drawer.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var fixedDrawer = MediaQuery.of(context).size.width > 800;

    return ChangeNotifierProvider(
      create: (context) => TabControllerModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.AppName),
        ),
        drawer: fixedDrawer ? null : MainPageDrawer(),
        body: fixedDrawer
            ? Row(children: [
                MainPageDrawer(),
                Flexible(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0.6,
                    child: MainPageBody(),
                  ),
                ),
              ])
            : MainPageBody(),
      ),
    );
  }
}
