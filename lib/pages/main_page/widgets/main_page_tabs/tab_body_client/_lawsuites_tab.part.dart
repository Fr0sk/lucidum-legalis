part of 'tab_body_client.dart';

class _LawsuitesTab extends StatefulWidget {
  final int clientId;
  final List<Lawsuite> lawsuites;

  const _LawsuitesTab(
      {Key? key, this.lawsuites = const [], required this.clientId})
      : super(key: key);

  @override
  State<_LawsuitesTab> createState() => _LawsuitesTabState();
}

class _LawsuitesTabState extends State<_LawsuitesTab> {
  var showOpened = true;
  var showAttention = true;
  var showWaiting = true;
  var showClosed = true;

  void onAddNewLawsuite() async {
    final lawsuiteId = await api.createLawsuite();
    api.associateClientLawsuiteByIds(widget.clientId, lawsuiteId);
    api.openLawsuite(id: lawsuiteId, editMode: true);
  }

  void onAssociateLawsuite() {
    api.omniboxController.show(
        hint: 'Choose Lawsuite to Associate'.tr(),
        allowClients: false,
        allowLawsuites: false,
        searchClients: false,
        onLawsuiteSelected: (lawsuite) {
          api.closeOmnibox();
          api.associateClientLawsuiteByIds(widget.clientId, lawsuite.id);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LawsuitesTabHeader(
          opened: widget.lawsuites
              .where((l) => l.state == LawsuiteState.open)
              .toList()
              .length,
          attention: widget.lawsuites
              .where((l) => l.state == LawsuiteState.requiresAttention)
              .toList()
              .length,
          waiting: widget.lawsuites
              .where((l) => l.state == LawsuiteState.waiting)
              .toList()
              .length,
          closed: widget.lawsuites
              .where((l) => l.state == LawsuiteState.closed)
              .toList()
              .length,
          openedEnabled: showOpened,
          attentionEnabled: showAttention,
          waitingEnabled: showWaiting,
          closedEnabled: showClosed,
          onAddNewLawsuite: onAddNewLawsuite,
          onAssociateLawsuite: onAssociateLawsuite,
          onOpenedPressed: () => setState(() => showOpened = !showOpened),
          onAttentionPressed: () =>
              setState(() => showAttention = !showAttention),
          onWaitingPressed: () => setState(() => showWaiting = !showWaiting),
          onClosedPressed: () => setState(() => showClosed = !showClosed),
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
              itemCount: widget.lawsuites.length,
              itemBuilder: (_, idx) {
                var lawsuite = widget.lawsuites[idx];
                if (lawsuite.state == LawsuiteState.open && !showOpened ||
                    lawsuite.state == LawsuiteState.requiresAttention &&
                        !showAttention ||
                    lawsuite.state == LawsuiteState.waiting && !showWaiting ||
                    lawsuite.state == LawsuiteState.closed && !showClosed) {
                  // Don't show lawsuites with disabled state
                  return Container();
                }

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
                          widget.clientId, lawsuite.id),
                );
              }),
        )
      ],
    );
  }
}
