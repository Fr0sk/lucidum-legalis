part of 'tab_body_lawsuite.dart';

class _StateMenu extends StatelessWidget {
  final LawsuiteState state;
  final void Function(LawsuiteState newState)? onChanged;

  const _StateMenu({
    Key? key,
    required this.state,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconUtils.lawsuiteIcon(state),
        ),
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
              child: DropdownButton<LawsuiteState>(
                value: state,
                focusNode: focusNode,
                onChanged: (newState) {
                  focusNode.unfocus();
                  if (newState != null) {
                    onChanged?.call(newState);
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: LawsuiteState.open,
                    child: Text(
                      'Opened'.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: LawsuiteState.closed,
                    child: Text(
                      'Closed'.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: LawsuiteState.waiting,
                    child: Text(
                      'Waiting'.tr(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: LawsuiteState.requiresAttention,
                    child: Text(
                      'Requires Attention'.tr(),
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
