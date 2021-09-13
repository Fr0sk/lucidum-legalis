import 'package:flutter/material.dart';

class ButtonGroup extends StatefulWidget {
  final bool radioMode;
  final double? height;
  final List<Widget> children;
  final int initialSelected;
  final Function(int index, bool enabled)? onPressed;

  const ButtonGroup({
    Key? key,
    this.radioMode = false,
    this.children = const [],
    this.initialSelected = -1,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  late final List<bool> _buttonSelected;

  @override
  void initState() {
    _buttonSelected = List.filled(widget.children.length, false);
    if (widget.initialSelected >= 0 &&
        widget.initialSelected < _buttonSelected.length) {
      _buttonSelected[widget.initialSelected] = true;
    }

    super.initState();
  }

  void _onButtonPressed(int index) {
    if (widget.radioMode) {
      setState(() {
        for (var i = 0; i < _buttonSelected.length; i++) {
          _buttonSelected[i] = i == index;
        }
      });
      widget.onPressed?.call(index, true);
    } else {
      _buttonSelected[index] = !_buttonSelected[index];
      widget.onPressed?.call(index, _buttonSelected[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ToggleButtons(
        isSelected: _buttonSelected,
        onPressed: _onButtonPressed,
        borderRadius: BorderRadius.circular(30),
        children: widget.children,
      ),
    );
  }
}

class ButtonGroupItem extends StatelessWidget {
  final double? width;
  final Widget? icon;
  final Widget? label;

  const ButtonGroupItem({Key? key, this.width, this.icon, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(icon != null || label != null);

    final body = <Widget>[];

    if (icon != null) {
      body.add(icon!);
    }

    if (label != null) {
      body.add(label!);
    }

    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: body,
        ),
      ),
    );
  }
}
