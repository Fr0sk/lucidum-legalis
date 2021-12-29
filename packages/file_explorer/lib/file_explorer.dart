import 'dart:io';
import 'file_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FileExplorer extends StatelessWidget {
  final FileExplorerController controller;
  final bool showLoadingIndicator;
  final MainAxisAlignment alignment;
  final Widget? folderIcon;
  final Widget? defaultFileIcon;
  final Widget? renameIcon;
  final Widget? deleteIcon;
  final Map<String, Widget>? fileIcons;
  final ScrollController? scrollController;
  final Widget? emptyFolderWidget;
  final void Function(FileSystemEntity)? onRename;
  final void Function(FileSystemEntity)? onDelete;

  const FileExplorer({
    Key? key,
    required this.controller,
    this.showLoadingIndicator = false,
    this.alignment = MainAxisAlignment.start,
    this.folderIcon,
    this.defaultFileIcon,
    this.fileIcons,
    this.renameIcon,
    this.deleteIcon,
    this.scrollController,
    this.emptyFolderWidget,
    this.onRename,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, path, child) {
        final entities = controller.directory.listSync();
        entities.sort(
          (e1, e2) {
            if (e1 is! Directory && e2 is Directory) {
              return 1;
            } else {
              return e1.path.compareTo(e2.path);
            }
          },
        );

        if (emptyFolderWidget != null && entities.isEmpty) {
          return emptyFolderWidget!;
        }

        return ValueListenableBuilder(
          valueListenable: controller.selected,
          builder: (_, selectedEntities, __) {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (_, index) {
                final e = entities[index];
                void Function() onPressed;
                Widget? icon;

                if (e is Directory) {
                  onPressed = () => controller.setDir(e.path);
                  icon = folderIcon;
                } else if (e is File) {
                  onPressed = () => controller.fileSelected?.call(e);
                  icon = fileIcons?[extension(e.path)] ?? defaultFileIcon;
                } else {
                  // e is Link
                  onPressed = () => controller.linkSelected?.call(e as Link);
                  icon = fileIcons?[extension(e.path)] ?? defaultFileIcon;
                }

                return _FileExplorerEntry(
                    label: Text(
                      basename(e.path),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    alignment: alignment,
                    onPressed: onPressed,
                    icon: icon,
                    checked: controller.selected.contains(e),
                    renameIcon: renameIcon,
                    deleteIcon: deleteIcon,
                    onRename: () => onRename?.call(e),
                    onDelete: () => onDelete?.call(e),
                    onChecked: (checked) {
                      if (checked == null) {
                        return;
                      }

                      if (checked) {
                        controller.selected.add(e);
                      } else {
                        controller.selected.remove(e);
                      }
                    });
              },
              separatorBuilder: (_, __) {
                return const Divider(height: 0);
              },
              itemCount: entities.length,
            );
          },
        );
      },
    );
  }
}

class _FileExplorerEntry extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onRename;
  final void Function()? onDelete;
  final void Function(bool? checked)? onChecked;
  final Widget label;
  final MainAxisAlignment alignment;
  final Widget? icon;
  final Widget? renameIcon;
  final Widget? deleteIcon;
  final bool checked;

  const _FileExplorerEntry({
    Key? key,
    required this.label,
    this.onPressed,
    this.icon,
    this.alignment = MainAxisAlignment.center,
    this.renameIcon,
    this.deleteIcon,
    this.onRename,
    this.onDelete,
    this.onChecked,
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Checkbox(value: checked, onChanged: onChecked),
          icon ?? Container(),
          const SizedBox(
            width: 8,
          ),
          Expanded(child: label),
          if (renameIcon != null) InkWell(onTap: onRename, child: renameIcon),
          if (deleteIcon != null) InkWell(onTap: onDelete, child: deleteIcon),
        ],
      ),
    );
  }
}
