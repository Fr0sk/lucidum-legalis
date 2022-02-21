part of 'settings_container.dart';

class _ListTileUpdates extends StatelessWidget {
  const _ListTileUpdates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Updates'.tr()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ValueListenableBuilder<bool>(
                  valueListenable: appSettings.checkForUpdates,
                  builder: (_, autoUpdaterEnabled, child) => SizedBox(
                    width: 400,
                    child: CheckboxListTile(
                        title:
                            Text('Automatic check and download updates'.tr()),
                        //controlAffinity: ListTileControlAffinity.leading,
                        value: autoUpdaterEnabled,
                        onChanged: (enabled) => appSettings
                            .checkForUpdates.value = enabled ?? false),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  child: Text('Check for updates'.tr()),
                  onPressed: () async {
                    await updaterService.checkForUpdates();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: updaterService.hasUpdates,
                  builder: (_, hasUpdates, child) => Badge(
                    position: const BadgePosition(top: -5, end: 0),
                    child: child,
                    showBadge: hasUpdates,
                  ),
                  child: SizedBox(
                    width: 125,
                    child: OutlinedButton(
                      child: Text('Restart'.tr()),
                      onPressed: () {
                        restart();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 125,
                  child: OutlinedButton(
                    child: Text('Exit'.tr()),
                    onPressed: () => exit(0),
                  ),
                ),
              ),
            ],
          ),
          const _UpdaterLabel(),
          ValueListenableBuilder<double?>(
            valueListenable: updaterService.downloadProgress,
            builder: (_, progress, __) => progress == null
                ? Container()
                : LinearProgressIndicator(
                    value: progress < 0 ? null : progress,
                  ),
          ),
          TextButton(
            onPressed: () => ReleaseNotesDialog.show(context: context),
            child: Text('View Release Notes'.tr()),
          ),
        ],
      ),
    );
  }
}
