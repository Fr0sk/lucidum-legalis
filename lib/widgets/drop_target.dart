import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AnimatedDropTarget extends StatefulWidget {
  final Widget child;
  final void Function(DropDoneDetails)? onDragDone;

  const AnimatedDropTarget({
    Key? key,
    required this.child,
    this.onDragDone,
  }) : super(key: key);

  @override
  State<AnimatedDropTarget> createState() => _AnimatedDropTargetState();
}

class _AnimatedDropTargetState extends State<AnimatedDropTarget> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: widget.onDragDone,
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: Container(
        color: _dragging ? Colors.lightBlue.withOpacity(0.4) : null,
        child: Stack(
          children: [
            widget.child,
            if (_dragging)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(MdiIcons.cloudUpload),
                    Text('Drop Files Here'.tr(),
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
