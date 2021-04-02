import 'package:flutter/material.dart';
import 'package:lucidum_legalis/constants/app_icons.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/base_tab.dart';

class ClientTab extends BaseTab {
  ClientTab({@required TabModel tabModel, @required String title})
      : super(
            tabModel: tabModel, title: title, leadIcon: Icon(AppIcons.CLIENT));
}
