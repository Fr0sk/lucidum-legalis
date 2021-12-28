import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/button_group.dart';
import 'package:lucidum_legalis/widgets/custom_tabs.dart';
import 'package:lucidum_legalis/widgets/flexible_text_field.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';
import '../file_explorer_tab.dart';
import '../information_header.dart';
import '../tab_body_base.dart';

part '_lawsuite_information_tab.part.dart';

class TabBodyLawsuite extends TabBodyBase<Lawsuite> {
  final _LawsuiteInformationTab _lawsuiteInformationTab;

  TabBodyLawsuite({required TabState<Lawsuite> state, Key? key})
      : _lawsuiteInformationTab = _LawsuiteInformationTab(tabState: state),
        super(key: key, state: state);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabs(
          headers: [
            ButtonGroupItem(
              icon: AppIcons.information,
              label: Text('Information'.tr()),
            ),
            ButtonGroupItem(
              icon: AppIcons.client,
              label: Text('Clients'.tr()),
            ),
            ButtonGroupItem(
              icon: AppIcons.files,
              label: Text('Files'.tr()),
            ),
          ],
          bodies: [
            _lawsuiteInformationTab,
            Container(color: Colors.orange),
            FileExplorerTab(
                path: AppDirectories.getLawsuiteDir(id: state.id).path),
          ],
        ),
      ],
    );
  }
}
