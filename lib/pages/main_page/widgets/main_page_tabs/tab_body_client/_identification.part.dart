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
    return TitledCard(
      titleText: 'Identification'.tr(),
      child: Row(
        children: [
          FlexibleTextField(
            controller: idNumberController,
            readOnly: readOnly,
            labelText: 'ID Number'.tr(),
          ),
          FlexibleTextField(
            controller: taxNumberController,
            readOnly: readOnly,
            labelText: 'Tax Number'.tr(),
            numberOnly: true,
          ),
          FlexibleTextField(
            controller: civilStatusController,
            readOnly: readOnly,
            labelText: 'Civil Status'.tr(),
          ),
        ],
      ),
    );
  }
}
