part of 'tab_body_client.dart';

class _LawsuitesTabHeader extends StatelessWidget {
  final int opened;
  final int attention;
  final int waiting;
  final int closed;
  final bool openedEnabled;
  final bool attentionEnabled;
  final bool waitingEnabled;
  final bool closedEnabled;
  final void Function()? onAddNewLawsuite;
  final void Function()? onAssociateLawsuite;
  final void Function()? onOpenedPressed;
  final void Function()? onAttentionPressed;
  final void Function()? onWaitingPressed;
  final void Function()? onClosedPressed;

  const _LawsuitesTabHeader(
      {Key? key,
      required this.opened,
      required this.attention,
      required this.waiting,
      required this.closed,
      this.onAddNewLawsuite,
      this.onAssociateLawsuite,
      this.onOpenedPressed,
      this.onAttentionPressed,
      this.onWaitingPressed,
      this.onClosedPressed,
      this.openedEnabled = true,
      this.attentionEnabled = true,
      this.waitingEnabled = true,
      this.closedEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Tooltip(
            message: 'Opened'.tr(),
            child: InkWell(
              onTap: onOpenedPressed,
              child: Row(
                children: [
                  openedEnabled
                      ? AppIcons.lawsuiteOpened
                      : AppIcons.lawsuiteOpenedDisabled,
                  Text('$opened'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Requires Attention'.tr(),
            child: InkWell(
              onTap: onAttentionPressed,
              child: Row(
                children: [
                  attentionEnabled
                      ? AppIcons.lawsuiteAttention
                      : AppIcons.lawsuiteAttentionDisabled,
                  Text('$attention'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Waiting'.tr(),
            child: InkWell(
              onTap: onWaitingPressed,
              child: Row(
                children: [
                  waitingEnabled
                      ? AppIcons.lawsuiteWaiting
                      : AppIcons.lawsuiteWaitingDisabled,
                  Text('$waiting'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Closed'.tr(),
            child: InkWell(
              onTap: onClosedPressed,
              child: Row(
                children: [
                  closedEnabled
                      ? AppIcons.lawsuiteClosed
                      : AppIcons.lawsuiteClosedDisabled,
                  Text('$closed'),
                ],
              ),
            ),
          ),
          const Spacer(),
          PopupMenuButton(
            icon: AppIcons.add,
            tooltip: 'Associate Lawsuite'.tr(),
            onSelected: (val) {
              if (val == 0) {
                onAddNewLawsuite?.call();
              } else {
                onAssociateLawsuite?.call();
              }
            },
            itemBuilder: (_) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    AppIcons.addLawsuite,
                    Text('Associate New Lawsuite'.tr()),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    AppIcons.lawsuiteSearch,
                    Text('Associate Existing Lawsuite'.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
