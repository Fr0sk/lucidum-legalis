part of 'file_explorer_tab.dart';

class _Toolbar extends StatelessWidget {
  final FileExplorerController controller;
  final void Function()? onFileUpload;
  final void Function()? onCreateFolder;
  final void Function()? onCopy;
  final void Function()? onCut;
  final void Function()? onPaste;
  final void Function()? onDelete;

  const _Toolbar({
    Key? key,
    required this.controller,
    this.onCreateFolder,
    this.onCopy,
    this.onCut,
    this.onPaste,
    this.onDelete,
    this.onFileUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, __, ___) => Tooltip(
              message: 'Back'.tr(),
              child: IconButton(
                onPressed: controller.canGoBack() ? controller.back : null,
                icon: AppIcons.back,
              ),
            ),
          ),
          const SizedBox(height: 20, child: VerticalDivider()), // Separator
          Tooltip(
            message: 'Open folder in explorer'.tr(),
            child: IconButton(
                onPressed: () => launch(controller.directory.path),
                icon: AppIcons.folderOpenColored),
          ),
          Tooltip(
            message: 'Add new folder'.tr(),
            child: IconButton(
                onPressed: onCreateFolder, icon: AppIcons.folderAddColored),
          ),
          Tooltip(
            message: 'Upload files'.tr(),
            child:
                IconButton(onPressed: onFileUpload, icon: AppIcons.fileUpload),
          ),
          PopupMenuButton(
            tooltip: 'Add new file'.tr(),
            child: AppIcons.fileAdd,
            onSelected: (selected) {
              // TODO handle selected
            },
            itemBuilder: (_) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () =>
                    Directory(p.join(controller.directory.path, 'Teste'))
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
          const SizedBox(height: 20, child: VerticalDivider()), // Separator
          Tooltip(
            message: 'Copy'.tr(),
            child: ValueListenableBuilder<List<FileSystemEntity>>(
              valueListenable: controller.selected,
              builder: (_, selected, __) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: selected.isEmpty ? null : onCopy,
                icon: AppIcons.copy,
              ),
            ),
          ),
          Tooltip(
            message: 'Cut'.tr(),
            child: ValueListenableBuilder<List<FileSystemEntity>>(
              valueListenable: controller.selected,
              builder: (_, selected, __) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: selected.isEmpty ? null : onCut,
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
                onPressed: selected.isEmpty ? null : onPaste,
                icon: AppIcons.paste,
              ),
            ),
          ),
          Tooltip(
            message: 'Delete'.tr(),
            child: ValueListenableBuilder<List<FileSystemEntity>>(
              valueListenable: controller.selected,
              builder: (_, selected, __) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: selected.isEmpty ? null : onDelete,
                icon: AppIcons.delete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
