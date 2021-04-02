import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/client_tab.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/tab_body/client_tab_body.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/tab_body/file_tab_body.dart';
import 'package:provider/provider.dart';

class MainPageBody extends StatelessWidget {
  List<Widget> _buildTabs(TabControllerModel tabModel) {
    var widgets = <Widget>[];

    for (var tabModel in tabModel.items) {
      widgets.add(
        ClientTab(tabModel: tabModel, title: '${tabModel.id}'),
      );
    }

    return widgets;
  }

  List<Widget> _buildTabBodys(TabControllerModel tabModel) {
    var widgets = <Widget>[];

    for (var tabModel in tabModel.items) {
      if (tabModel.type == TabType.CLIENT) {
        widgets.add(ClientTabBody(tabModel: tabModel));
      } else if (tabModel.type == TabType.CLIENT) {
        widgets.add(FileTabBody(tabModel: tabModel));
      } else {
        widgets.add(
          Icon(Icons.directions_transit),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final tabModel = context.watch<TabControllerModel>();

    return DefaultTabController(
      length: tabModel.items.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 48,
          bottom: TabBar(
            isScrollable: true,
            tabs: _buildTabs(tabModel),
          ),
        ),
        body: TabBarView(
          children: _buildTabBodys(tabModel),
        ),
      ),
    );
  }
}
