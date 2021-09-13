import 'package:file_explorer/file_explorer.dart';
import 'package:file_explorer/file_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FileExplorerTab extends StatelessWidget {
  final String path;
  final FileExplorerController _controller;
  FileExplorerTab({Key? key, required this.path})
      : _controller = FileExplorerController(
          startPath: path,
          watch: true,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (_, __, ___) => IconButton(
                  onPressed: _controller.canGoBack() ? _controller.back : null,
                  icon: Icon(LineIcons.arrowLeft),
                ),
              ),
            ],
          ),
          Expanded(
            child: FileExplorer(controller: _controller),
          ),
        ],
      ),
    );
  }
}
