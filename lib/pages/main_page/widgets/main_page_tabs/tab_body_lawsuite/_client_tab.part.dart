part of 'tab_body_lawsuite.dart';

class _ClientTab extends StatelessWidget {
  final int lawsuiteId;
  final List<Client> clients;

  const _ClientTab({Key? key, required this.lawsuiteId, required this.clients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ClientRow(name: 'Name'.tr(), createdAt: 'Created At'.tr()),
        const Divider(),
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: clients.length,
            itemBuilder: (_, idx) {
              final client = clients[idx];
              return _ClientRow(
                name: client.name,
                createdAt: DateFormat('dd-MM-yyyy').format(
                  client.createdAt,
                ),
                icon: IconUtils.clientIcon(client.type),
                onPressed: () => api.openClient(id: client.id),
                onDeletePressed: () => api.deleteClientLawsuiteAssociationByIds(
                    client.id, lawsuiteId),
              );
            },
          ),
        ),
      ],
    );
  }
}
