part of 'tab_body_client.dart';

class _Address extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController cityController;
  final TextEditingController countyController;
  final bool readOnly;

  const _Address(
      {Key? key,
      required this.streetController,
      required this.zipCodeController,
      required this.cityController,
      required this.countyController,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Address'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(children: [
          Row(children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: streetController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Street'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: zipCodeController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Zip Code'.tr()),
                ),
              ),
            ),
          ]),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: TextField(
                    controller: cityController,
                    readOnly: readOnly,
                    decoration: InputDecoration(labelText: 'City'.tr()),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: TextField(
                    controller: countyController,
                    readOnly: readOnly,
                    decoration: InputDecoration(labelText: 'County'.tr()),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
