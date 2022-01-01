import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/utils.dart';

class OmniboxListTileClient extends StatelessWidget {
  final Client client;
  final void Function()? onPressed;

  const OmniboxListTileClient({Key? key, required this.client, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: IconUtils.clientIcon(client.type),
        title: Text(client.name),
        onTap: onPressed);
  }
}
