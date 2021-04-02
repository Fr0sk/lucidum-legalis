import 'package:flutter/material.dart';
import 'package:lucidum_legalis/models/tab_controller_model.dart';

class FileTabBody extends StatefulWidget {
  final TabModel tabModel;

  const FileTabBody({Key key, @required this.tabModel}) : super(key: key);
  @override
  _FileTabBodyState createState() => _FileTabBodyState();
}

class _FileTabBodyState extends State<FileTabBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                ListTile(title: Text('Name'), subtitle: TextField()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
