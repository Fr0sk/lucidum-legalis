import 'package:flutter/material.dart';

class SizedElevatedButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double? width;
  final double? height;

  const SizedElevatedButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
