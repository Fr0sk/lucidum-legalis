part of 'tab_body_client.dart';

class _LawsuitesTab extends StatelessWidget {
  final int clientId;
  final List<Lawsuite> lawsuites;

  const _LawsuitesTab(
      {Key? key, this.lawsuites = const [], required this.clientId})
      : super(key: key);

  void onAddNewLawsuite() async {
    final lawsuiteId = await api.createLawsuite();
    api.associateClientLawsuiteByIds(clientId, lawsuiteId);
    api.openLawsuite(id: lawsuiteId, editMode: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LawsuitesTabHeader(
          opened: lawsuites
              .where((l) => l.state == LawsuiteState.open)
              .toList()
              .length,
          attention: lawsuites
              .where((l) => l.state == LawsuiteState.requiresAttention)
              .toList()
              .length,
          waiting: lawsuites
              .where((l) => l.state == LawsuiteState.waiting)
              .toList()
              .length,
          closed: lawsuites
              .where((l) => l.state == LawsuiteState.closed)
              .toList()
              .length,
          onAddNewLawsuite: onAddNewLawsuite,
          onAssociateLawsuite: () {
            print('Associate lawsuite');
          },
        ),
        _LawsuitesRow(
          id: 'No.',
          name: 'Name'.tr(),
          processNumber: 'Process Number'.tr(),
          createdAt: 'Created At'.tr(),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
              controller: ScrollController(),
              itemCount: lawsuites.length,
              itemBuilder: (_, idx) {
                var lawsuite = lawsuites[idx];
                return _LawsuitesRow(
                  id: '${lawsuite.id}',
                  name: lawsuite.name,
                  processNumber: lawsuite.processNumber ?? '',
                  createdAt: DateFormat('dd-MM-yyyy').format(
                    lawsuite.createdAt,
                  ),
                  icon: IconUtils.lawsuiteIcon(lawsuite.state),
                  onPressed: () => api.openLawsuite(id: lawsuite.id),
                  onDeletePressed: () =>
                      api.deleteClientLawsuiteAssociationByIds(
                          clientId, lawsuite.id),
                );
              }),
        )
      ],
    );
  }
}
