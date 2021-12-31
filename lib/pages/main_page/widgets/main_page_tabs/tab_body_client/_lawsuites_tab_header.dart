part of 'tab_body_client.dart';

class _LawsuitesTabHeader extends StatelessWidget {
  final int opened;
  final int attention;
  final int waiting;
  final int closed;
  final void Function()? onAddNewLawsuite;
  final void Function()? onAssociateLawsuite;

  const _LawsuitesTabHeader(
      {Key? key,
      required this.opened,
      required this.attention,
      required this.waiting,
      required this.closed,
      this.onAddNewLawsuite,
      this.onAssociateLawsuite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Tooltip(
            message: 'Opened'.tr(),
            child: Row(
              children: [
                AppIcons.lawsuiteOpened,
                Text('$opened'),
              ],
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Requires Attention'.tr(),
            child: Row(
              children: [
                AppIcons.lawsuiteAttention,
                Text('$attention'),
              ],
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Waiting'.tr(),
            child: Row(
              children: [
                AppIcons.lawsuiteWaiting,
                Text('$waiting'),
              ],
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Closed'.tr(),
            child: Row(
              children: [
                AppIcons.lawsuiteClosed,
                Text('$closed'),
              ],
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
