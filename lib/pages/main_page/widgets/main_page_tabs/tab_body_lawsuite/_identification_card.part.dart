part of 'tab_body_lawsuite.dart';

class _IdentificationCard extends StatelessWidget {
  final int lawsuiteId;
  final bool editMode;
  final List<_AgainstController> againstControllers;

  const _IdentificationCard({
    Key? key,
    required this.lawsuiteId,
    required this.againstControllers,
    this.editMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: Row(
        children: [
          Text('Against Identification'.tr(),
              style: Theme.of(context).textTheme.headline6),
          const Spacer(),
          if (editMode)
            TextButton(
              onPressed: () {
                userDatabase.lawsuiteDao.insertAgainst(
                  LawsuiteAgainstsCompanion.insert(
                    lawsuiteId: lawsuiteId,
                  ),
                );
              },
              child: Text('Add against field'.tr()),
            ),
        ],
      ),
      child: StreamBuilder<List<LawsuiteAgainst>>(
          stream: userDatabase.lawsuiteDao.watchAllAgainst(lawsuiteId),
          builder: (_, snapshot) {
            // Populate controllers list
            for (var against in snapshot.data ?? <LawsuiteAgainst>[]) {
              if (against.lawsuiteId != lawsuiteId) {
                continue;
              }
              if (againstControllers.indexWhere((c) => c.id == against.id) ==
                  -1) {
                againstControllers.add(
                  _AgainstController(
                      id: against.id,
                      againstText: against.against,
                      vatText: against.vat,
                      addressText: against.address),
                );
              }
            }

            // Create children
            final children = <Widget>[];
            for (var controller in againstControllers) {
              children.add(Row(
                children: [
                  FlexibleTextField(
                    controller: controller.against,
                    readOnly: !editMode,
                    labelText: 'Against'.tr(),
                    flex: 2,
                  ),
                  FlexibleTextField(
                    controller: controller.address,
                    readOnly: !editMode,
                    labelText: 'Address'.tr(),
                    flex: 2,
                  ),
                  DynamicTextField(
                    controller: controller.vat,
                    readOnly: !editMode,
                    label: 'Tax Number'.tr(),
                    deleteTooltip: 'Remove this field'.tr(),
                    onDelete: () async {
                      await userDatabase.lawsuiteDao
                          .deleteAgainstById(controller.id);
                      againstControllers
                          .removeWhere((c) => c.id == controller.id);
                    },
                  ),
                ],
              ));
            }

            if (children.isEmpty) {
              children.add(
                Text(
                  'No opposing party'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
              );
            }
            return Column(children: children);
            //return CustomGrid(columns: 2, children: children);
          }),
    );
  }
}
