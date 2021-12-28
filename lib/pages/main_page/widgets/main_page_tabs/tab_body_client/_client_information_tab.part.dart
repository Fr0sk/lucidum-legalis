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
  final _countyController = TextEditingController();

  _ClientInformationTab({Key? key, required this.tabState}) : super(key: key);

  void _onSave() {
    final client = tabState.dataNotifier.value;

    if (client != null) {
      api.saveClient(
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
          county: _countyController.text,
        ),
      );
      tabState.edit = false;
    }
  }

  void _onDelete() {
    // Todo Fix _onDelete
    final client = tabState.dataNotifier.value;
    if (client != null) {
      api.closeTab(tabState: tabState);
      api.deleteClient(client);
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

        return ValueListenableBuilder(
          valueListenable: state.editNotifier,
          builder: (_, editMode, __) {
            if (!state.edit) {
              // If loading data
              _nameController.text = client.name;
              _idNumberController.text = client.idNumber ?? '';
              _taxNumberController.text = client.taxNumber?.toString() ?? '';
              _civilStatusController.text = client.civilStatus ?? '';
              _streetController.text = client.street ?? '';
              _zipCodeController.text = client.zipCode ?? '';
              _cityController.text = client.city ?? '';
              _countyController.text = client.county ?? '';
            }

            return Column(
              children: [
                InformationHeader(
                  nameController: _nameController,
                  readOnly: !state.edit,
                  icon: AppIcons.client,
                  onEdit: state.toggleEdit,
                  onSave: _onSave,
                  onDelete: _onDelete,
                ),
                _Identification(
                  idNumberController: _idNumberController,
                  taxNumberController: _taxNumberController,
                  civilStatusController: _civilStatusController,
                  readOnly: !state.edit,
                ),
                _Address(
                  streetController: _streetController,
                  zipCodeController: _zipCodeController,
                  cityController: _cityController,
                  countyController: _countyController,
                  readOnly: !state.edit,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
