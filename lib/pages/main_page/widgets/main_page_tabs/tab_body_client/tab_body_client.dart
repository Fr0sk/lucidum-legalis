import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/page_header.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/file_explorer_tab.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/widgets/button_group.dart';
import 'package:lucidum_legalis/widgets/custom_tabs.dart';

import '../information_header.dart';
import '../tab_body_base.dart';

part '_client_information_tab.part.dart';
part '_identification.part.dart';
part '_address.part.dart';

class TabBodyClient extends TabBodyBase<Client> {
  final _ClientInformationTab _clientInformationTab;

  TabBodyClient({required TabState<Client> state, Key? key})
      : _clientInformationTab = _ClientInformationTab(tabState: state),
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
              icon: AppIcons.lawsuite,
              label: Text('Lawsuites'.tr()),
            ),
            ButtonGroupItem(
              icon: AppIcons.files,
              label: Text('Files'.tr()),
            ),
          ],
          bodies: [
            _clientInformationTab,
            Container(color: Colors.green),
            FileExplorerTab(
              header: PageHeader(
                icon: AppIcons.client,
                label: StreamBuilder<Client>(
                  stream: state.dataStream,
                  builder: (_, snapshot) => Text(snapshot.data?.name ?? ''),
                ),
              ),
              path: AppDirectories.getClientDir(id: state.id).path,
            ),
          ],
        ),
      ],
    );
  }
}
