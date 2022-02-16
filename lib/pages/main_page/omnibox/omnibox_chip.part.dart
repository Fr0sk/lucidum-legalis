part of 'omnibox.dart';

class _OmniboxChip extends StatelessWidget {
  final ValueListenable<bool> valueListenable;
  final ValueListenable<bool> canToggleListenable;
  final Widget avatar;
  final Widget label;
  final void Function() onPressed;

  const _OmniboxChip({
    Key? key,
    required this.valueListenable,
    required this.avatar,
    required this.label,
    required this.onPressed,
    required this.canToggleListenable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: canToggleListenable,
      builder: (__, canToggle, _) => ValueListenableBuilder<bool>(
        valueListenable: valueListenable,
        builder: (_, enabled, __) => ActionChip(
          labelStyle: DefaultTextStyle.of(context)
              .style
              .copyWith(color: enabled ? Theme.of(context).cardColor : null),
          avatar: IconTheme(
              data: IconThemeData(
                  color: enabled ? Theme.of(context).cardColor : null),
              child: avatar),
          label: label,
          backgroundColor: enabled ? Theme.of(context).primaryColor : null,
          onPressed: canToggle ? onPressed : () {},
        ),
      ),
    );
  }
}
