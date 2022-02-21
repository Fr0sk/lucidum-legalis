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
                  valueListenable: appSettings.saveOpenTabs,
                  builder: (_, saveOpenTabs, child) => SizedBox(
                    width: 400,
                    child: CheckboxListTile(
                        title: Text('Save tabs on exit'.tr()),
                        //controlAffinity: ListTileControlAffinity.leading,
                        value: saveOpenTabs,
                        onChanged: (enabled) =>
                            appSettings.saveOpenTabs.value = enabled ?? false),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
