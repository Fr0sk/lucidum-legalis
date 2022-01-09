part of 'tab_body_lawsuite.dart';

class _ClientRow extends StatelessWidget {
  final String name;
  final String createdAt;
  final Widget? icon;
  final void Function()? onPressed;
  final void Function()? onDeletePressed;

  const _ClientRow({
    Key? key,
    required this.name,
    required this.createdAt,
    this.icon,
    this.onPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          primary: Theme.of(context).textTheme.bodyText1?.color),
      onPressed: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: Row(
                  children: [
                    if (icon != null) icon!,
                    Expanded(child: Text(name, softWrap: true)),
                  ],
                ),
              ),
            ),
            const VerticalDivider(),
            Flexible(
              flex: 1,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      createdAt,
                      softWrap: true,
                    ),
                    const Spacer(),
                    if (onDeletePressed != null)
                      Tooltip(
                        waitDuration: App.tooltipWait,
                        message: 'Remove Association'.tr(),
                        child: TextButton(
                          onPressed: onDeletePressed,
                          child: AppIcons.lawsuiteRemoveAssociation,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
