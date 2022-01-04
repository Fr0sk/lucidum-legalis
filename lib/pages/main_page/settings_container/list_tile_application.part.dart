part of 'settings_container.dart';

class _ListTileApplication extends StatelessWidget {
  const _ListTileApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Application'.tr()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ValueListenableBuilder<bool>(
                  valueListenable: updaterService.autoUpdater,
                  builder: (_, autoUpdaterEnabled, child) => SizedBox(
                    width: 225,
                    child: CheckboxListTile(
                        title:
                            Text('Automatic check and download updates'.tr()),
                        //controlAffinity: ListTileControlAffinity.leading,
                        value: autoUpdaterEnabled,
                        onChanged: (enabled) => updaterService
                            .autoUpdater.value = enabled ?? false),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 225,
                  child: OutlinedButton(
                    child: Text('Check for updates'.tr()),
                    onPressed: () async {
                      await updaterService.checkForUpdates();
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                    width: 225,
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
                  width: 225,
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
        ],
      ),
    );
  }
}
