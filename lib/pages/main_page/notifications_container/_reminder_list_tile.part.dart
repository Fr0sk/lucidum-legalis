part of 'notifications_container.dart';

class _ReminderListTile extends StatelessWidget {
  final Alert reminder;
  const _ReminderListTile({Key? key, required this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final metadataId = int.tryParse(reminder.metadata ?? '');

    Widget? icon;
    Widget? subtitle;
    void Function()? onTap;

    if (reminder.type == AlertType.lawsuite && metadataId != null) {
      icon = StreamBuilder<Lawsuite>(
          stream: userDatabase.lawsuiteDao.watchLawsuiteById(metadataId),
          builder: (context, snapshot) => snapshot.data == null
              ? Container()
              : IconUtils.lawsuiteIcon(snapshot.data!.state));
      subtitle = StreamBuilder<Lawsuite>(
        stream: userDatabase.lawsuiteDao.watchLawsuiteById(metadataId),
        builder: (context, snapshot) =>
            Text('#${snapshot.data?.id ?? ""} - ${snapshot.data?.name ?? ""}'),
      );
      onTap = () => api.openLawsuit(id: metadataId);
    }

    return ListTile(
      title: Badge(
        position: BadgePosition.topStart(top: 0),
        showBadge: reminder.emitAt.difference(DateTime.now()).inDays <= 0,
        child: Row(
          children: [
            if (icon != null) icon,
            const SizedBox(width: 5),
            SizedBox(
              width: 190,
              child: Text(
                reminder.title ?? '',
                overflow: TextOverflow.clip,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => api.openReminder(reminder.id),
              icon: AppIcons.edit,
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null) subtitle,
          Row(
            children: [
              AppIcons.reminderDeadline,
              Text(DateFormat('dd-MMM-yy').format(reminder.emitAt)),
              const Spacer(),
              AppIcons.reminderRemainingTime,
              ValueListenableBuilder(
                valueListenable: appAlerts.refresh,
                builder: (context, date, child) {
                  final diff = reminder.emitAt.difference(DateTime.now());
                  var remainingText = 'Overdue!'.tr();

                  if (diff.inDays > 0) {
                    remainingText =
                        '{} days'.tr(args: [diff.inDays.toString()]);
                  } else if (diff.inHours > 0) {
                    remainingText =
                        '{} hours'.tr(args: [diff.inHours.toString()]);
                  }
                  return Text(remainingText);
                },
              ),
            ],
          )
        ],
      ),
      isThreeLine: true,
      onTap: onTap,
    );
  }
}
