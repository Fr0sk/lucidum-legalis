import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/widgets/titled_card.dart';

class NotificationsContainer extends StatelessWidget {
  final double width;
  final void Function()? onDismiss;

  const NotificationsContainer({Key? key, required this.width, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(100, 0, 0, 0),
        ),
        Row(
          children: [
            // Dismissable area
            Expanded(
              child: InkWell(
                hoverColor: const Color.fromARGB(0, 0, 0, 0),
                onTap: onDismiss,
              ),
            ),

            // Settings panel
            SizedBox(
              width: width,
              child: TitledCard(
                titleText: 'Notifications'.tr(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No new notifications'.tr(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
