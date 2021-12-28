part of 'tab_body_lawsuite.dart';

class _LawsuiteInformationTab extends StatelessWidget {
  final TabState<Lawsuite> tabState;

  final _nameController = TextEditingController();
  final _againstController = TextEditingController();
  final _codeController = TextEditingController();
  final _processNumberController = TextEditingController();
  final _districtController = TextEditingController();
  final _courtController = TextEditingController();
  final _judgementController = TextEditingController();
  final _formController = TextEditingController();

  _LawsuiteInformationTab({Key? key, required this.tabState}) : super(key: key);

  void _onSave() {
    final lawsuite = tabState.dataNotifier.value;

    if (lawsuite != null) {
      api.saveLawsuite(lawsuite.copyWith(
          name: _nameController.text,
          against: _againstController.text,
          code: _codeController.text,
          processNumber: _processNumberController.text,
          district: _districtController.text,
          court: _courtController.text,
          judgement: _judgementController.text,
          form: _formController.text));

      tabState.edit = false;
    }
  }

  void _onDelete() {
    final lawsuite = tabState.dataNotifier.value;
    if (lawsuite != null) {
      api.closeTab(tabState: tabState);
      api.deleteLawsuite(lawsuite);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = tabState;

    return ValueListenableBuilder<Lawsuite?>(
      valueListenable: state.dataNotifier,
      builder: (_, lawsuite, __) {
        if (lawsuite == null) {
          // lawsuite is loading
          return Container();
        }

        return ValueListenableBuilder(
          valueListenable: state.editNotifier,
          builder: (_, editMode, __) {
            if (!state.edit) {
              // If loading data
              _nameController.text = lawsuite.name;
              _againstController.text = lawsuite.against ?? '';
              _codeController.text = lawsuite.code ?? '';
              _processNumberController.text = lawsuite.processNumber ?? '';
              _districtController.text = lawsuite.district ?? '';
              _courtController.text = lawsuite.court ?? '';
              _judgementController.text = lawsuite.judgement ?? '';
              _formController.text = lawsuite.form ?? '';
            }

            return Column(
              children: [
                InformationHeader(
                  nameController: _nameController,
                  readOnly: !state.edit,
                  icon: AppIcons.lawsuite,
                  onEdit: state.toggleEdit,
                  onSave: _onSave,
                  onDelete: _onDelete,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      'Against'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: TextField(
                                  controller: _againstController,
                                  readOnly: !state.edit,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      'Judgment'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Column(
                      children: [
                        Row(children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: TextField(
                                controller: _processNumberController,
                                readOnly: !state.edit,
                                decoration: InputDecoration(
                                    labelText: 'Process Number'.tr()),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: TextField(
                                controller: _districtController,
                                readOnly: !state.edit,
                                decoration:
                                    InputDecoration(labelText: 'District'.tr()),
                              ),
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: TextField(
                                  controller: _courtController,
                                  readOnly: !state.edit,
                                  decoration:
                                      InputDecoration(labelText: 'Court'.tr()),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: TextField(
                                  controller: _judgementController,
                                  readOnly: !state.edit,
                                  decoration: InputDecoration(
                                      labelText: 'Judgement'.tr()),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: TextField(
                                  controller: _formController,
                                  readOnly: !state.edit,
                                  decoration:
                                      InputDecoration(labelText: 'Form'.tr()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
