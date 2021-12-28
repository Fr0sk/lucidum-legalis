part of 'tab_body_client.dart';

class _Identification extends StatelessWidget {
  final TextEditingController idNumberController;
  final TextEditingController taxNumberController;
  final TextEditingController civilStatusController;
  final bool readOnly;

  const _Identification(
      {Key? key,
      required this.idNumberController,
      required this.taxNumberController,
      required this.civilStatusController,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Identification'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: idNumberController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'ID Number'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: taxNumberController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Tax Number'.tr()),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  controller: civilStatusController,
                  readOnly: readOnly,
                  decoration: InputDecoration(labelText: 'Civil Status'.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
