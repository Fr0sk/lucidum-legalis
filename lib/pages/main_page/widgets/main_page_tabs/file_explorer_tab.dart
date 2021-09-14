import 'dart:io';

import 'package:file_explorer/file_explorer.dart';
import 'package:file_explorer/file_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart' as p;

class FileExplorerTab extends StatelessWidget {
  final String path;
  final Widget? header;
  final FileExplorerController _controller;

  FileExplorerTab({Key? key, required this.path, this.header})
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
          if (header != null) header!,
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (_, __, ___) => IconButton(
                  onPressed: _controller.canGoBack() ? _controller.back : null,
                  icon: Icon(LineIcons.arrowLeft),
                ),
              ),
              PopupMenuButton(
                onSelected: (selected) {
                  print('selected');
                },
                itemBuilder: (_) => <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () =>
                        Directory(p.join(_controller.directory.path, 'Teste'))
                            .create(recursive: true),
                    child: Row(
                      children: [
                        Icon(Icons.folder),
                        SizedBox(width: 8),
                        Text('Add Directory')
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.folder),
                        SizedBox(width: 8),
                        Text('Add Directory')
                      ],
                    ),
                  ),
                ],
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
