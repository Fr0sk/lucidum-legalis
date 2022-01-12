part of 'tab_body_lawsuite.dart';

class _LawsuiteInformationTab extends StatelessWidget {
  final TabState<Lawsuite> tabState;

  final _nameController = TextEditingController();
  final _processNumberController = TextEditingController();
  final _districtController = TextEditingController();
  final _courtController = TextEditingController();
  final _judgementController = TextEditingController();
  final _formController = TextEditingController();
  final _legalSupportController = TextEditingController();
  final _againstControllers = <_AgainstController>[];
  final _nameTextFieldFocusNode = FocusNode();

  _LawsuiteInformationTab({Key? key, required this.tabState}) : super(key: key);

  Future<void> _onSave() async {
    final lawsuite = tabState.dataNotifier.value;

    if (lawsuite != null) {
      await api.saveLawsuite(lawsuite.copyWith(
        name: _nameController.text,
        processNumber: _processNumberController.text,
        district: _districtController.text,
        court: _courtController.text,
        judgement: _judgementController.text,
        form: _formController.text,
        legalSupportNumber: _legalSupportController.text,
      ));

      for (var controller in _againstControllers) {
        await userDatabase.lawsuiteDao.updateAgainst(
          LawsuiteAgainstsCompanion(
            id: drift.Value(controller.id),
            against: drift.Value(controller.against.text),
            vat: drift.Value(controller.vat.text),
            address: drift.Value(controller.against.text),
            lawsuiteId: drift.Value(lawsuite.id),
          ),
        );
      }

      tabState.edit = false;
    }
  }

  Future<void> _onDelete(BuildContext context) async {
    final lawsuite = tabState.dataNotifier.value;
    if (lawsuite != null) {
      final result = await YesNoDialog.show(
          context: context,
          title: 'Delete {}?'.tr(args: [lawsuite.name]),
          description:
              'This action will also delete all the files associated with this lawsuite.'
                  .tr());
      if (result) {
        api.closeTab(tabState: tabState);
        api.deleteLawsuite(lawsuite);
      }
    }
  }

  Future<void> onStateChanged(LawsuiteState newState) async {
    final lawsuite = tabState.dataNotifier.value;
    if (lawsuite != null && lawsuite.state != newState) {
      await api.saveLawsuite(lawsuite.copyWith(state: newState));
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

        return ValueListenableBuilder<bool>(
          valueListenable: state.editNotifier,
          builder: (_, editMode, __) {
            _nameController.text = lawsuite.name;
            if (!editMode) {
              // If loading data
              _processNumberController.text = lawsuite.processNumber ?? '';
              _districtController.text = lawsuite.district ?? '';
              _courtController.text = lawsuite.court ?? '';
              _judgementController.text = lawsuite.judgement ?? '';
              _formController.text = lawsuite.form ?? '';
              _legalSupportController.text = lawsuite.legalSupportNumber ?? '';
              _againstControllers.clear();
            } else {
              // On edit select name text
              _nameController.selection = TextSelection(
                  baseOffset: 0, extentOffset: _nameController.text.length);
              _nameTextFieldFocusNode.requestFocus();
            }

            return SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  InformationHeader(
                    title: 'Lawsuite: {}'.tr(args: ['${lawsuite.id}']),
                    editMode: state.edit,
                    icon: IconUtils.lawsuiteIcon(lawsuite.state),
                    onEdit: state.toggleEdit,
                    onSave: _onSave,
                    onDelete: () => _onDelete(context),
                    onRight: Tooltip(
                      message: 'Add reminder'.tr(),
                      child: IconButton(
                          onPressed: () async {
                            final reminderId =
                                await api.createLawsuiteReminder(lawsuite.id);
                            await api.openReminder(reminderId);
                          },
                          icon: AppIcons.reminderAdd),
                    ),
                    child: Row(
                      children: [
                        FlexibleTextField(
                          controller: _nameController,
                          readOnly: !state.edit,
                          decoration: InputDecoration(labelText: 'Name'.tr()),
                          focusNode: _nameTextFieldFocusNode,
                        ),
                        _StateMenu(
                          state: lawsuite.state,
                          onChanged: onStateChanged,
                        ),
                      ],
                    ),
                  ),
                  _IdentificationCard(
                    lawsuiteId: lawsuite.id,
                    againstControllers: _againstControllers,
                    editMode: state.edit,
                  ),
                  TitledCard(
                    titleText: 'Judgement'.tr(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            FlexibleTextField(
                              controller: _processNumberController,
                              readOnly: !state.edit,
                              labelText: 'Process Number'.tr(),
                            ),
                            FlexibleTextField(
                              controller: _legalSupportController,
                              readOnly: !state.edit,
                              labelText: 'Legal Support Number'.tr(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FlexibleTextField(
                              controller: _districtController,
                              readOnly: !state.edit,
                              labelText: 'District'.tr(),
                            ),
                            FlexibleTextField(
                              controller: _courtController,
                              readOnly: !state.edit,
                              labelText: 'Court'.tr(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FlexibleTextField(
                              controller: _judgementController,
                              readOnly: !state.edit,
                              labelText: 'Judge/Section'.tr(),
                            ),
                            FlexibleTextField(
                              controller: _formController,
                              readOnly: !state.edit,
                              labelText: 'Form'.tr(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Created at {}'.tr(
                            args: [
                              DateFormat('dd-MM-yyyy')
                                  .format(lawsuite.createdAt),
                            ],
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
