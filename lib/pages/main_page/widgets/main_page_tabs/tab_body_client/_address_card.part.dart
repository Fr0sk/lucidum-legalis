part of 'tab_body_client.dart';

class _AddressCard extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController zipCodeController;
  final TextEditingController cityController;
  final ClientType type;
  final bool readOnly;

  const _AddressCard(
      {Key? key,
      required this.streetController,
      required this.zipCodeController,
      required this.cityController,
      required this.readOnly,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      titleText:
          type == ClientType.company ? 'Headquarters'.tr() : 'Address'.tr(),
      child: Column(
        children: [
          Row(
            children: [
              FlexibleTextField(
                controller: streetController,
                readOnly: readOnly,
                labelText: 'Street'.tr(),
              ),
            ],
          ),
          Row(
            children: [
              FlexibleTextField(
                controller: zipCodeController,
                readOnly: readOnly,
                labelText: 'Zip Code'.tr(),
              ),
              FlexibleTextField(
                controller: cityController,
                readOnly: readOnly,
                labelText: 'City'.tr(),
              ),
            ],
          )
        ],
      ),
    );

    /*
    GridView.count(
        crossAxisCount: 2,
        children: [
          FlexibleTextField(
            controller: streetController,
            readOnly: readOnly,
            labelText: 'Street'.tr(),
          ),
          FlexibleTextField(
            controller: zipCodeController,
            readOnly: readOnly,
            labelText: 'Zip Code'.tr(),
          ),
          FlexibleTextField(
            controller: cityController,
            readOnly: readOnly,
            labelText: 'City'.tr(),
          ),
          FlexibleTextField(
            controller: countyController,
            readOnly: readOnly,
            labelText: 'County'.tr(),
          ),
        ],
      ),
    Column(
        children: [
          Row(
            children: [
              FlexibleTextField(
                controller: streetController,
                readOnly: readOnly,
                labelText: 'Street'.tr(),
              ),
              FlexibleTextField(
                controller: zipCodeController,
                readOnly: readOnly,
                labelText: 'Zip Code'.tr(),
              ),
            ],
          ),
          Row(
            children: [
              FlexibleTextField(
                controller: cityController,
                readOnly: readOnly,
                labelText: 'City'.tr(),
              ),
              FlexibleTextField(
                controller: countyController,
                readOnly: readOnly,
                labelText: 'County'.tr(),
              ),
            ],
          )
        ],
      ),
    */
  }
}
