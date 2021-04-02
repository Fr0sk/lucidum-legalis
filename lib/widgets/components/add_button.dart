import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key key, this.onPressed, this.label, this.icon})
      : super(key: key);

  final Function onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Icon(icon),
                  ),
                ],
              ),
              Center(child: Text(label)),
            ],
          ),
        ),
      ),
    );
  }
}
