import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/utils.dart';

class OmniboxListTileLawsuite extends StatelessWidget {
  final Lawsuite lawsuite;
  final void Function()? onPressed;

  const OmniboxListTileLawsuite(
      {Key? key, required this.lawsuite, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconUtils.lawsuiteIcon(lawsuite.state),
      title: Text(lawsuite.name),
      subtitle: Row(
        children: [
          Text('# ' + lawsuite.id.toString()),
          const VerticalDivider(),
          Text(lawsuite.processNumber ?? ''),
        ],
      ),
      onTap: onPressed,
    );
  }
}
