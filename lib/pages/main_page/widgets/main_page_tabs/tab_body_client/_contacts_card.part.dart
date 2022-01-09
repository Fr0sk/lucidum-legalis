part of 'tab_body_client.dart';

class _ContactsCard extends StatelessWidget {
  final int clientId;
  final bool editMode;
  final List<DynamicTextFieldController<ContactType>> contactsControllers;

  const _ContactsCard({
    Key? key,
    required this.clientId,
    required this.editMode,
    required this.contactsControllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: Row(
        children: [
          Text('Contacts'.tr(), style: Theme.of(context).textTheme.headline6),
          const Spacer(),
          if (editMode)
            PopupMenuButton<ContactType>(
              onSelected: (type) {
                userDatabase.clientDao.insertContact(
                  ContactsCompanion.insert(
                    clientId: clientId,
                    contactType: type,
                  ),
                );
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: ContactType.phone,
                  child: Text('Phone'.tr()),
                ),
                PopupMenuItem(
                  value: ContactType.mobile,
                  child: Text('Mobile'.tr()),
                ),
                PopupMenuItem(
                  value: ContactType.email,
                  child: Text('Email'.tr()),
                ),
              ],
              child: Text(
                'Add contact'.tr(),
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
        ],
      ),
      child: StreamBuilder<List<Contact>>(
        stream: userDatabase.clientDao.watchAllContacts(clientId),
        builder: (_, snapshot) {
          // Populate controllers list
          for (var contact in snapshot.data ?? <Contact>[]) {
            if (contact.clientId != clientId) {
              continue;
            }

            if (contactsControllers.indexWhere((c) => c.id == contact.id) ==
                -1) {
              contactsControllers.add(
                DynamicTextFieldController<ContactType>(
                    id: contact.id,
                    text: contact.contact,
                    custom: contact.contactType),
              );
            }
          }

          // Create children
          final children = <Widget>[];
          for (var controller in contactsControllers) {
            String label;
            switch (controller.custom) {
              case ContactType.phone:
                label = 'Phone'.tr();
                break;
              case ContactType.mobile:
                label = 'Mobile'.tr();
                break;
              case ContactType.email:
                label = 'Email'.tr();
                break;
              default:
                label = '';
            }

            children.add(
              DynamicTextField(
                controller: controller,
                readOnly: !editMode,
                label: label,
                deleteTooltip: 'Remove this field'.tr(),
                onDelete: () async {
                  await userDatabase.clientDao.deleteContactById(controller.id);
                  contactsControllers.removeWhere((c) => c.id == controller.id);
                },
              ),
            );
          }

          return CustomGrid(columns: 2, children: children);
        },
      ),
    );
  }
}
