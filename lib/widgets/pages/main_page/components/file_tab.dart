import 'package:lucidum_legalis/constants/app_icons.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/base_tab.dart';
import 'package:flutter/material.dart';

class FileTab extends BaseTab {
  FileTab({@required TabModel tabModel, String title})
      : super(tabModel: tabModel, title: title, leadIcon: Icon(AppIcons.FILE));
}
