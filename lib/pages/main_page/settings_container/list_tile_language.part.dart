part of 'settings_container.dart';

class _ListTileLanguage extends StatelessWidget {
  const _ListTileLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Language'.tr()),
      subtitle: DropdownButton<Locale>(
        value: context.locale,
        items: const [
          DropdownMenuItem(
            child: Text('English'),
            value: Locales.en,
          ),
          DropdownMenuItem(
            child: Text('Português'),
            value: Locales.pt,
          ),
        ],
        onChanged: (newLocale) {
          if (newLocale != null) {
            context.setLocale(newLocale);
          }
        },
      ),
    );
  }
}
