import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseTab extends StatelessWidget {
  final TabModel tabModel;
  final String title;
  final Icon leadIcon;

  BaseTab({@required this.tabModel, this.title, this.leadIcon});

  void _closeTab(TabControllerModel tabControllerModel) {
    tabControllerModel.close(tabModel);
  }

  void _onPointerDown(PointerDownEvent event, TabControllerModel tabModel) {
    if (event.buttons == kMiddleMouseButton) {
      _closeTab(tabModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabModel = context.read<TabControllerModel>();

    return Listener(
      onPointerDown: (event) => _onPointerDown(event, tabModel),
      child: Tab(
        icon: Row(
          children: [
            leadIcon,
            Text(' $title'),
            CloseButton(
              onPressed: () => _closeTab(tabModel),
            ),
          ],
        ),
      ),
    );
  }
}
