part of 'tab_body_client.dart';

class _ClientInformationTab extends StatelessWidget {
  final TabState<Client> tabState;

  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _contactsControllers = <DynamicTextFieldController<ContactType>>[];
  final _nameTextFieldFocusNode = FocusNode();

  _ClientInformationTab({Key? key, required this.tabState}) : super(key: key);

  Future<void> _onSave() async {
    final client = tabState.dataNotifier.value;

    if (client != null) {
      await api.saveClient(
        client.copyWith(
          name: _nameController.text,
          idNumber: _idNumberController.text,
          taxNumber: _taxNumberController.text.isEmpty
              ? null
              : int.parse(_taxNumberController.text),
          civilStatus: _civilStatusController.text,
          street: _streetController.text,
          zipCode: _zipCodeController.text,
          city: _cityController.text,
        ),
      );

      for (var controller in _contactsControllers) {
        await userDatabase.clientDao.updateContact(
          ContactsCompanion(
              id: drift.Value(controller.id),
              contact: drift.Value(controller.text),
              contactType: drift.Value(controller.custom!),
              clientId: drift.Value(client.id)),
        );
      }

      tabState.edit = false;
    }
  }

  Future<void> _onDelete(BuildContext context) async {
    final client = tabState.dataNotifier.value;

    if (client != null) {
      final result = await YesNoDialog.show(
          context: context,
          title: 'Delete {}?'.tr(args: [client.name]),
          description:
              'This action will also delete all the files associated with this client.'
                  .tr());
      if (result) {
        api.closeTab(tabState: tabState);
        api.deleteClient(client);
      }
    }
  }

  Future<void> onTypeChanged(ClientType newType) async {
    final client = tabState.dataNotifier.value;
    if (client != null && client.type != newType) {
      await api.saveClient(client.copyWith(type: newType));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = tabState;

    return ValueListenableBuilder<Client?>(
      valueListenable: state.dataNotifier,
      builder: (_, client, __) {
        if (client == null) {
          // Client is loading
          return Container();
        }

        return ValueListenableBuilder<bool>(
          valueListenable: state.editNotifier,
          builder: (_, editMode, __) {
            _nameController.text = client.name;
            if (!state.edit) {
              // If loading data
              _idNumberController.text = client.idNumber ?? '';
              _taxNumberController.text = client.taxNumber?.toString() ?? '';
              _civilStatusController.text = client.civilStatus ?? '';
              _streetController.text = client.street ?? '';
              _zipCodeController.text = client.zipCode ?? '';
              _cityController.text = client.city ?? '';
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
                    title: 'Client'.tr(),
                    editMode: state.edit,
                    icon: IconUtils.clientIcon(client.type),
                    onEdit: state.toggleEdit,
                    onSave: _onSave,
                    onDelete: () => _onDelete(context),
                    child: Row(
                      children: [
                        FlexibleTextField(
                          controller: _nameController,
                          readOnly: !state.edit,
                          decoration: InputDecoration(labelText: 'Name'.tr()),
                          focusNode: _nameTextFieldFocusNode,
                        ),
                        _TypeMenu(
                          type: client.type,
                          onChanged: onTypeChanged,
                        )
                      ],
                    ),
                  ),
                  _Identification(
                    idNumberController: _idNumberController,
                    taxNumberController: _taxNumberController,
                    civilStatusController: _civilStatusController,
                    readOnly: !state.edit,
                    type: client.type,
                  ),
                  _AddressCard(
                    streetController: _streetController,
                    zipCodeController: _zipCodeController,
                    cityController: _cityController,
                    readOnly: !state.edit,
                    type: client.type,
                  ),
                  _ContactsCard(
                      clientId: state.id,
                      editMode: editMode,
                      contactsControllers: _contactsControllers),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Created at {}'.tr(
                            args: [
                              DateFormat('dd-MM-yyyy').format(client.createdAt),
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
