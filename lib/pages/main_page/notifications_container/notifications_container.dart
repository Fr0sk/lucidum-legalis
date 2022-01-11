import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/tables/alerts.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/flexible_text_field.dart';
import 'package:lucidum_legalis/utils/extensions.dart';

part '_reminder_edit_view.part.dart';
part '_reminder_list_tile.part.dart';

class NotificationsContainer extends StatelessWidget {
  final double width;

  const NotificationsContainer({Key? key, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: SizedBox(
        width: width,
        child: ValueListenableBuilder<Alert?>(
          valueListenable: api.openedReminder,
          builder: (_, reminder, __) {
            if (reminder != null) {
              return _ReminderEditView(reminder: reminder);
            }

            return StreamBuilder<List<Alert>>(
              stream: userDatabase.alertDao.watchNotEmitted(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  // Whlie loading
                  return Container();
                }

                return ListView.separated(
                  controller: ScrollController(),
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, idx) =>
                      _ReminderListTile(reminder: snapshot.data![idx]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
