part of 'settings_container.dart';

class _UpdaterLabel extends StatelessWidget {
  const _UpdaterLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: updaterService.hasUpdates,
      builder: (_, hasUpdates, __) => ValueListenableBuilder<DateTime?>(
        valueListenable: updaterService.lastCheck,
        builder: (_, dateChecked, __) {
          var text = '';
          if (hasUpdates) {
            text = 'Restart to install the latest update'.tr();
          } else if (dateChecked != null) {
            text = 'Updated. Last check: {}'
                .tr(args: [DateFormat('dd MMM yy hh:mm').format(dateChecked)]);
          }
          return Text(
            text,
            style: Theme.of(context).textTheme.caption,
          );
        },
      ),
    );
  }
}
