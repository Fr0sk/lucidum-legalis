import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class FileExplorerController extends ValueNotifier<String> {
  final String startPath;
  final bool onlySubdirectories;
  final bool watch;
  final void Function(File f)? fileSelected;
  final void Function(Link e)? linkSelected;
  final void Function(FileSystemEntity entity)? onRename;
  final void Function(FileSystemEntity entity)? onDelete;

  StreamSubscription? _dirWatchStream;

  FileExplorerController({
    this.startPath = '',
    this.onlySubdirectories = true,
    this.watch = false,
    this.fileSelected,
    this.linkSelected,
    this.onRename,
    this.onDelete,
  }) : super(Directory(startPath).path) {
    if (watch) {
      _watchDir();
    }
  }

  Directory get directory => Directory(value).absolute;
  Directory get startDirectory => Directory(startPath).absolute;

  bool validDirectory(String dir) {
    return !onlySubdirectories ||
        path.isWithin(startDirectory.path, Directory(dir).absolute.path) ||
        path.equals(startDirectory.path, Directory(dir).absolute.path);
  }

  bool canGoBack() => validDirectory(directory.parent.absolute.path);

  void back() {
    if (canGoBack()) {
      value = directory.parent.absolute.path;
      notifyListeners();
    }
  }

  void setDir(String dir) {
    if (validDirectory(dir)) {
      value = dir;
      _watchDir();
      notifyListeners();
    }
  }

  void refreshDir() {
    setDir(value);
  }

  Future<void> _watchDir() async {
    await _dirWatchStream?.cancel();
    _dirWatchStream = directory.watch().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _dirWatchStream?.cancel();
    super.dispose();
  }
}
