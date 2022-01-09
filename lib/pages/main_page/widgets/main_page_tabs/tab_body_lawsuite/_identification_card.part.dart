part of 'tab_body_lawsuite.dart';

class _IdentificationCard extends StatelessWidget {
  final int lawsuiteId;
  final TextEditingController codeController;
  final bool editMode;
  final List<DynamicTextFieldController> againstControllers;

  const _IdentificationCard({
    Key? key,
    required this.lawsuiteId,
    required this.codeController,
    required this.againstControllers,
    this.editMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: Row(
        children: [
          Text('Identification'.tr(),
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
                againstControllers.add(DynamicTextFieldController(
                    id: against.id, text: against.against));
              }
            }

            // Create children
            final children = <Widget>[
              FlexibleTextField(
                controller: codeController,
                readOnly: !editMode,
                labelText: 'Code'.tr(),
              ),
            ];

            for (var controller in againstControllers) {
              children.add(
                DynamicTextField(
                  controller: controller,
                  readOnly: !editMode,
                  label: 'Against'.tr(),
                  deleteTooltip: 'Remove this field'.tr(),
                  onDelete: () async {
                    await userDatabase.lawsuiteDao
                        .deleteAgainstById(controller.id);
                    againstControllers
                        .removeWhere((c) => c.id == controller.id);
                  },
                ),
              );
            }

            return CustomGrid(columns: 2, children: children);
          }),
    );
  }
}