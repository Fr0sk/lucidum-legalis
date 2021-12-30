part of 'tab_body_client.dart';

class _TypeMenu extends StatelessWidget {
  final ClientType type;
  final void Function(ClientType newState)? onChanged;

  const _TypeMenu({
    Key? key,
    required this.type,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconUtils.clientSettingsIcon(type)),
        Stack(
          alignment: AlignmentDirectional.centerStart,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text('State'.tr(),
                  style: Theme.of(context).textTheme.caption),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: DropdownButton<ClientType>(
                value: type,
                focusNode: focusNode,
                onChanged: (newType) {
                  focusNode.unfocus();
                  if (newType != null) {
                    onChanged?.call(newType);
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: ClientType.person,
                    child: Text(
                      'Person'.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: ClientType.company,
                    child: Text(
                      'Company'.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
