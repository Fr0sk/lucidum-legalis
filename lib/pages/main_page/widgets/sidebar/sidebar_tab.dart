import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'sidebar_client_list_tile.dart';
import 'sidebar_lawsuite_list_tile.dart';

class SidebarTab extends StatelessWidget {
  final Stream<List<dynamic>> dataStream;
  final void Function(int id)? onClientPressed;
  final void Function(int id)? onLawsuitePressed;

  const SidebarTab(
      {Key? key,
      required this.dataStream,
      this.onClientPressed,
      this.onLawsuitePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: dataStream,
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return const SingleChildScrollView();
        }

        final list = snapshot.data!;

        return ListView.separated(
          itemCount: list.length + 1,
          itemBuilder: (_, index) {
            if (index == list.length) {
              return const SizedBox(height: 25);
            }

            if (list is List<Client>) {
              return SidebarClientListTile(
                client: list[index],
                onTap: () => onClientPressed?.call(list[index].id),
              );
            } else if (list is List<Lawsuite>) {
              return SidebarLawsuiteListTile(
                lawsuite: list[index],
                onTap: () => onLawsuitePressed?.call(list[index].id),
              );
            } else {
              return Container(color: Colors.red);
            }
          },
          separatorBuilder: (_, __) => const Divider(
            height: 0,
          ),
        );
      },
    );
  }
}
