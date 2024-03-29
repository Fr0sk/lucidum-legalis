import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_explorer/file_explorer.dart';
import 'package:file_explorer/file_explorer_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/dialogs/text_input_dialog.dart';
import 'package:lucidum_legalis/dialogs/yes_no_dialog.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/drop_target.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher_string.dart';

part '_toolbar.part.dart';

class FileExplorerTab extends StatelessWidget {
  final String path;
  final String? basePathMask;
  final FileExplorerController _controller;

  FileExplorerTab({Key? key, required this.path, this.basePathMask})
      : _controller = FileExplorerController(
            startPath: path,
            watch: true,
            fileSelected: (file) async {
              launchUrlString(file.path);
            }),
        super(key: key);

  Future<void> onEntityRename(
      BuildContext context, FileSystemEntity entity) async {
    var result = await TextInputDialog.show(
      context: context,
      title: 'Change Name'.tr(),
      labelText: 'New name',
      defaultText: p.basename(entity.path),
    );

    if (result != null && result.isNotEmpty) {
      await entity.rename(p.join(entity.parent.path, result));
    }
  }

  Future<void> onEntityDelete(
    BuildContext context,
    FileSystemEntity entity,
  ) async {
    bool confirm = false;

    if (await File(entity.path).exists()) {
      confirm = await YesNoDialog.show(
        context: context,
        title: 'Delete {}?'.tr(args: [p.basename(entity.path)]),
        description:
            'Are you sure you want to permanently delete this file?'.tr(),
      );
    } else if (await Directory(entity.path).exists()) {
      confirm = await YesNoDialog.show(
        context: context,
        title: 'Delete {}?'.tr(args: [p.basename(entity.path)]),
        description:
            'Are you sure you want to permanently delete this folder?'.tr(),
      );
    }

    if (confirm) {
      entity.delete(recursive: true);
    }
  }

  Future<void> createFolder(BuildContext context) async {
    var dir = Directory(p.join(_controller.directory.path, 'New Folder'.tr()));
    var i = 0;

    while (await dir.exists()) {
      i++;
      dir =
          Directory(p.join(_controller.directory.path, 'New Folder ($i)'.tr()));
    }

    await dir.create(recursive: true);
    await onEntityRename(context, dir);
  }

  Future<void> onCopy(BuildContext context) async {
    await api.copyFiles(_controller.selected.value);
  }

  Future<void> onCut(BuildContext context) async {
    await api.cutFiles(_controller.selected.value);
  }

  Future<void> onPaste(BuildContext context) async {
    await api.pasteFiles(_controller.directory, context);
  }

  Future<void> onDelete(BuildContext context) async {
    if (_controller.selected.isEmpty) {
      return;
    }

    final confirm = await YesNoDialog.show(
      context: context,
      title:
          'Delete {} Files?'.tr(args: [_controller.selected.length.toString()]),
      description: 'Are you sure you want to permanently '
              'delete selected files and folders?'
          .tr(),
    );

    if (!confirm) {
      return;
    }

    for (var e in _controller.selected.value) {
      await e.delete(recursive: true);
    }
    _controller.selected.value = [];
  }

  Future<void> onFileUpload(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final paths = <String>[];

      for (var path in result.paths) {
        if (path != null) {
          paths.add(path);
        }
      }

      if (paths.isNotEmpty) {
        await Copy.list(paths, _controller.directory, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _Toolbar(
            controller: _controller,
            onCreateFolder: () => createFolder(context),
            onCopy: () => onCopy(context),
            onCut: () => onCut(context),
            onPaste: () => onPaste(context),
            onDelete: () => onDelete(context),
            onFileUpload: () => onFileUpload(context),
          ),
          Row(
            children: [
              ValueListenableBuilder<String>(
                  valueListenable: _controller,
                  builder: (_, dir, __) {
                    return (Text((basePathMask ?? '') +
                        dir.substring(_controller.startPath.length)));
                  }),
            ],
          ),
          Expanded(
            child: AnimatedDropTarget(
              onDragDone: (details) {
                Copy.list(details.files.map((e) => e.path).toList(),
                    _controller.directory, context);
              },
              child: FileExplorer(
                controller: _controller,
                scrollController: ScrollController(),
                onRename: (entity) => onEntityRename(context, entity),
                onDelete: (entity) => onEntityDelete(context, entity),
                renameIcon: AppIcons.edit,
                deleteIcon: AppIcons.delete,
                folderIcon: AppIcons.folderColored,
                defaultFileIcon: AppIcons.fileUnkown,
                fileIcons: Mappings.filesIcons,
                emptyFolderWidget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'This folder is empty'.tr(),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
