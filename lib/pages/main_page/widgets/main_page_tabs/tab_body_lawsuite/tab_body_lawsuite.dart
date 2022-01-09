import 'package:drift/drift.dart' as drift;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/dialogs/yes_no_dialog.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/dynamic_text_field.dart';
import 'package:lucidum_legalis/pages/main_page/widgets/dynamic_text_field_controller.part.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/button_group.dart';
import 'package:lucidum_legalis/widgets/custom_grid.dart';
import 'package:lucidum_legalis/widgets/custom_tabs.dart';
import 'package:lucidum_legalis/widgets/flexible_text_field.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';
import '../file_explorer_tab/file_explorer_tab.dart';
import '../information_header.dart';
import '../tab_body_base.dart';

part '_lawsuite_information_tab.part.dart';
part '_state_menu.part.dart';
part '_identification_card.part.dart';
part '_client_tab.part.dart';
part '_client_row.part.dart';

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
            StreamBuilder<List<Client>>(
              stream: api.database.clientLawsuiteDao
                  .watchClientsByLawsuiteId(state.id),
              builder: (_, snapshot) => _ClientTab(
                lawsuiteId: state.id,
                clients: snapshot.data ?? [],
              ),
            ),
            ValueListenableBuilder<Lawsuite?>(
                valueListenable: state.dataNotifier,
                builder: (_, lawsuite, __) {
                  return FileExplorerTab(
                      basePathMask: lawsuite?.name,
                      path: AppDirectories.getLawsuiteDir(id: state.id).path);
                }),
          ],
        ),
      ],
    );
  }
}
