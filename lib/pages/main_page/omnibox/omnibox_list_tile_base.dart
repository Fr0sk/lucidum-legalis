import 'package:flutter/material.dart';

abstract class OmniboxListTileBase extends StatelessWidget {
  final void Function()? onPressed;
  final selected = ValueNotifier<bool>(false);

  OmniboxListTileBase({Key? key, this.onPressed}) : super(key: key);
}
