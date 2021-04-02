import 'package:flutter/material.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';
import 'package:lucidum_legalis/widgets/pages/main_page/components/tab_body/flexible_text_field.dart';

enum ClientType { PERSON, BUSINESS }

class ClientTabBody extends StatefulWidget {
  final TabModel tabModel;

  const ClientTabBody({Key key, @required this.tabModel}) : super(key: key);
  @override
  _ClientTabBodyState createState() => _ClientTabBodyState();
}

class _ClientTabBodyState extends State<ClientTabBody> {
  ClientType clientType = ClientType.PERSON;

  String _getClientTypeAsString(ClientType clientType) {
    switch (clientType) {
      case ClientType.BUSINESS:
        return 'Business';
      case ClientType.PERSON:
        return 'Person';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.account_box_outlined),
                    Text('Identificação'),
                    Spacer(),
                    Text('Tipo de cliente:  '),
                    DropdownButton<ClientType>(
                      value: clientType,
                      onChanged: (newType) =>
                          setState(() => clientType = newType),
                      items: ClientType.values
                          .map(
                            (type) => DropdownMenuItem<ClientType>(
                              value: type,
                              child: Text(_getClientTypeAsString(type)),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    if (clientType == ClientType.PERSON)
                      FlexibleTextField(
                        labelText: 'Número de CC',
                      ),
                    FlexibleTextField(
                      labelText: 'Número de Contribuinte',
                    ),
                    if (clientType == ClientType.PERSON)
                      FlexibleTextField(
                        labelText: 'Estado Civil',
                      ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.access_alarms_outlined),
                    Text('Morada')
                  ],
                ),
                subtitle: Row(
                  children: [
                    FlexibleTextField(
                      labelText: 'Rua',
                      flex: 2,
                    ),
                    FlexibleTextField(
                      labelText: 'Código Postal',
                    ),
                    FlexibleTextField(
                      labelText: 'Freguesia',
                    ),
                    FlexibleTextField(
                      labelText: 'Distrito',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
