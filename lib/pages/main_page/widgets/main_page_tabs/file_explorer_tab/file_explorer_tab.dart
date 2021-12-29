import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_explorer/file_explorer.dart';
import 'package:file_explorer/file_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/dialogs/text_input_dialog.dart';
import 'package:lucidum_legalis/dialogs/yes_no_dialog.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/drop_target.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class FileExplorerTab extends StatelessWidget {
  final String path;
  final String? basePathMask;
  final FileExplorerController _controller;

  FileExplorerTab({Key? key, required this.path, this.basePathMask})
      : _controller = FileExplorerController(
            startPath: path,
            watch: true,
            fileSelected: (file) async {
              launch(file.path);
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
      BuildContext context, FileSystemEntity entity) async {
    bool confirm = false;

    if (await File(entity.path).exists()) {
      confirm = await YesNoDialog.show(
        context: context,
        title: 'Delete ${p.basename(entity.path)}?'.tr(),
        description:
            'Are you sure you want to permanently delete this file?'.tr(),
      );
    } else if (await Directory(entity.path).exists()) {
      confirm = await YesNoDialog.show(
        context: context,
        title: 'Delete ${p.basename(entity.path)}?'.tr(),
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
    onEntityRename(context, dir);
  }

  Future<void> onCopy(BuildContext context) async {
    await api.copyFiles(_controller.selected.value);
  }

  Future<void> onCut(BuildContext context) async {
    await api.cutFiles(_controller.selected.value);
  }

  Future<void> onPaste(BuildContext context) async {
    await api.pasteFiles(_controller.directory);
  }

  Future<void> onDelete(BuildContext context) async {
    for (var e in _controller.selected.value) {
      await onEntityDelete(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //if (header != null) header!,
          Card(
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (_, __, ___) => IconButton(
                    onPressed:
                        _controller.canGoBack() ? _controller.back : null,
                    icon: AppIcons.back,
                  ),
                ),
                Tooltip(
                  message: 'Open folder in explorer'.tr(),
                  child: IconButton(
                      onPressed: () => launch(_controller.directory.path),
                      icon: AppIcons.folderOpenColored),
                ),
                Tooltip(
                  message: 'Add new folder'.tr(),
                  child: IconButton(
                      onPressed: () => createFolder(context),
                      icon: AppIcons.folderAddColored),
                ),
                PopupMenuButton(
                  tooltip: 'Add new file'.tr(),
                  child: AppIcons.fileAdd,
                  onSelected: (selected) {
                    print('Selected');
                    // TODO handle selected
                  },
                  itemBuilder: (_) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () =>
                          Directory(p.join(_controller.directory.path, 'Teste'))
                              .create(recursive: true),
                      child: Row(
                        children: const [
                          Icon(Icons.folder),
                          SizedBox(width: 8),
                          Text('Add Directory')
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.folder),
                          SizedBox(width: 8),
                          Text('Add Directory')
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20, child: VerticalDivider()),
                Tooltip(
                  message: 'Copy'.tr(),
                  child: ValueListenableBuilder<List<FileSystemEntity>>(
                    valueListenable: _controller.selected,
                    builder: (_, selected, __) => IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed:
                          selected.isEmpty ? null : () => onCopy(context),
                      icon: AppIcons.copy,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Cut'.tr(),
                  child: ValueListenableBuilder<List<FileSystemEntity>>(
                    valueListenable: _controller.selected,
                    builder: (_, selected, __) => IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: selected.isEmpty ? null : () => onCut(context),
                      icon: AppIcons.cut,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Paste'.tr(),
                  child: ValueListenableBuilder<List<FileSystemEntity>>(
                    valueListenable: api.selectedFiles,
                    builder: (_, selected, __) => IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed:
                          selected.isEmpty ? null : () => onPaste(context),
                      icon: AppIcons.paste,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Delete'.tr(),
                  child: ValueListenableBuilder<List<FileSystemEntity>>(
                    valueListenable: _controller.selected,
                    builder: (_, selected, __) => IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed:
                          selected.isEmpty ? null : () => onDelete(context),
                      icon: AppIcons.delete,
                    ),
                  ),
                ),
              ],
            ),
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
                    _controller.directory);
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
                emptyFolderWidget: Text(
                  'This folder is empty'.tr(),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
