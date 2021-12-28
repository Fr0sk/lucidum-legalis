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
    return TitledCard(
      titleText: 'Address'.tr(),
      child: Column(
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
