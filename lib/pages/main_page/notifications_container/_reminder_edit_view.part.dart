part of 'notifications_container.dart';

class _ReminderEditView extends StatelessWidget {
  final Alert reminder;
  const _ReminderEditView({Key? key, required this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: reminder.title);
    final descriptionController = TextEditingController(text: reminder.content);
    final emitDate = ValueNotifier<DateTime>(reminder.emitAt);

    return SizedBox.expand(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FlexibleTextField(
                labelText: 'Title'.tr(),
                controller: titleController,
                autofocus: true,
              ),
              FlexibleTextField(
                labelText: 'Description'.tr(),
                controller: descriptionController,
                maxLines: 5,
              ),
              const Divider(),
              ValueListenableBuilder<DateTime>(
                valueListenable: emitDate,
                builder: (_, date, __) {
                  return Row(
                    children: [
                      AppIcons.reminderDeadline,
                      Text(DateFormat('dd-MMM-yy').format(date)),
                      const Spacer(),
                      AppIcons.reminderRemainingTime,
                      ValueListenableBuilder(
                        valueListenable: appAlerts.refresh,
                        builder: (context, _, child) {
                          final diff = date.difference(DateTime.now());
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
                  );
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Set deadline'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: 1)),
                    child: Text('{} days'.tr(args: ['+1'])),
                  ),
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: -1)),
                    child: Text('{} days'.tr(args: ['-1'])),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: 5)),
                    child: Text('{} days'.tr(args: ['+5'])),
                  ),
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: -5)),
                    child: Text('{} days'.tr(args: ['-5'])),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: 10)),
                    child: Text('{} days'.tr(args: ['+10'])),
                  ),
                  TextButton(
                    onPressed: () => emitDate.value =
                        emitDate.value.add(const Duration(days: -10)),
                    child: Text('{} days'.tr(args: ['-10'])),
                  ),
                ],
              ),
              TextButton(
                onPressed: () async {
                  final newDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      initialDate: emitDate.value,
                      lastDate: DateTime(2100));
                  if (newDate != null) {
                    emitDate.value = newDate.endDay;
                  }
                },
                child: Text('Pick date'.tr()),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await userDatabase.alertDao.updateAlert(
                        reminder
                            .copyWith(
                              title: titleController.text,
                              content: descriptionController.text,
                              emitAt: emitDate.value,
                            )
                            .toCompanion(true),
                      );
                      api.closeReminder();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text(
                      'Save'.tr(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      api.closeReminder();
                      await userDatabase.alertDao.deleteAlert(reminder);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Row(
                      children: [
                        Text(
                          'Delete'.tr(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
