import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/page_header.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/main_page_tabs/file_explorer_tab.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;
import 'package:lucidum_legalis/widgets/button_group.dart';
import 'package:lucidum_legalis/widgets/custom_tabs.dart';
import 'package:provider/provider.dart';

import 'client_information_tab.dart';
import 'tab_body_base.dart';

class TabBodyClient extends TabBodyBase<Client> {
  TabBodyClient(TabState<Client> state) : super(state: state);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabs(
          headers: [
            ButtonGroupItem(
              icon: constants.AppIcons.information,
              label: Text('Information'.tr()),
            ),
            ButtonGroupItem(
              icon: constants.AppIcons.lawsuite,
              label: Text('Lawsuites'.tr()),
            ),
            ButtonGroupItem(
              icon: constants.AppIcons.files,
              label: Text('Files'.tr()),
            ),
          ],
          bodies: [
            ClientInformationTab(),
            Container(color: Colors.green),
            FileExplorerTab(
                header: PageHeader(
                  icon: constants.AppIcons.client,
                  label: StreamBuilder<Client>(
                    stream: state.data,
                    builder: (_, snapshot) => Text(snapshot.data?.name ?? ''),
                  ),
                ),
                path:
                    context.read<Api>().user!.getClientDir(id: state.id).path),
          ],
        ),
      ],
    );
  }
}
