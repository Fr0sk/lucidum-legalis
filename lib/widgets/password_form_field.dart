import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;

  const PasswordFormField(
      {Key? key,
      this.controller,
      this.focusNode,
      this.decoration = const InputDecoration(),
      this.validator,
      this.onFieldSubmitted,
      this.autofocus = false})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  var _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final icon = _hidePassword ? Icons.visibility : Icons.visibility_off;

    final decoration = widget.decoration.copyWith(
      suffixIcon: IconButton(
        focusNode: FocusNode(skipTraversal: true),
        onPressed: () => setState(() => _hidePassword = !_hidePassword),
        icon: Icon(icon),
      ),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: widget.validator,
      autofocus: widget.autofocus,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: decoration,
      obscureText: _hidePassword,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
