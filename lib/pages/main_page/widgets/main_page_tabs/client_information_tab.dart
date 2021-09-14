import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/api.dart';
import 'package:provider/provider.dart';
import 'package:lucidum_legalis/utils/constants.dart' as constants;

class ClientInformationTab extends StatefulWidget {
  const ClientInformationTab({Key? key}) : super(key: key);

  @override
  _ClientInformationTabState createState() => _ClientInformationTabState();
}

class _ClientInformationTabState extends State<ClientInformationTab> {
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _countyController = TextEditingController();

  void _onSave(Api api, TabState tabState, Client client) {
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

  void _onDelete(Api api, Client client) {
    api.closeTab();
    api.deleteClient(client);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState<Client>>(
      builder: (_, state, _child) {
        return StreamBuilder<Client>(
          stream: state.data,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return Container();
            }

            final client = snapshot.data!;

            return Column(
              children: [
                _Header(
                  nameController: _nameController..text = client.name,
                  readOnly: !state.edit,
                  onEdit: () => state.toggleEdit(),
                  onSave: () => _onSave(context.read<Api>(), state, client),
                  onDelete: () => _onDelete(context.read<Api>(), client),
                ),
                _Identification(
                  idNumberController: _idNumberController
                    ..text = client.idNumber ?? '',
                  taxNumberController: _taxNumberController
                    ..text = '${client.taxNumber ?? ""}',
                  civilStatusController: _civilStatusController
                    ..text = client.civilStatus ?? '',
                  readOnly: !state.edit,
                ),
                _Address(
                    streetController: _streetController
                      ..text = client.street ?? '',
                    zipCodeController: _zipCodeController
                      ..text = client.zipCode ?? '',
                    cityController: _cityController..text = client.city ?? '',
                    countyController: _countyController
                      ..text = client.county ?? '',
                    readOnly: !state.edit),
              ],
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final TextEditingController nameController;
  final bool readOnly;
  final void Function()? onEdit;
  final void Function()? onSave;
  final void Function()? onDelete;

  const _Header({
    Key? key,
    required this.nameController,
    required this.readOnly,
    this.onEdit,
    this.onSave,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            constants.AppIcons.client,
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                  controller: nameController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Name'.tr()),
                ),
              ),
            ),
            Spacer(),
            readOnly
                ? Container()
                : IconButton(
                    onPressed: onSave,
                    icon: constants.AppIcons.save,
                    color: Colors.green,
                  ),
            readOnly
                ? Container()
                : IconButton(
                    onPressed: onDelete,
                    icon: constants.AppIcons.delete,
                    color: Colors.red[700],
                  ),
            IconButton(
              onPressed: onEdit,
              icon: constants.AppIcons.edit,
              color: readOnly ? null : Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _Identification extends StatelessWidget {
  final TextEditingController idNumberController;
  final TextEditingController taxNumberController;
  final TextEditingController civilStatusController;
  final bool readOnly;

  const _Identification(
      {Key? key,
      required this.idNumberController,
      required this.taxNumberController,
      required this.civilStatusController,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Identification'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: idNumberController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'ID Number'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: taxNumberController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Tax Number'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: civilStatusController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Civil Status'.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Address extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController cityController;
  final TextEditingController countyController;
  final bool readOnly;

  const _Address(
      {Key? key,
      required this.streetController,
      required this.zipCodeController,
      required this.cityController,
      required this.countyController,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Address'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(children: [
          Row(children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: streetController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Street'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: zipCodeController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Zip Code'.tr()),
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
                    controller: cityController,
                    readOnly: readOnly,
                    decoration: InputDecoration(labelText: 'City'.tr()),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: TextField(
                    controller: countyController,
                    readOnly: readOnly,
                    decoration: InputDecoration(labelText: 'County'.tr()),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
