import 'dart:io';
import 'package:path/path.dart' as p;

class Copy {
  static Future<void> directory(Directory source, Directory destination) async {
    await for (var entity in source.list(recursive: false)) {
      if (entity is Directory) {
        var newDirectory = Directory(
            p.join(destination.absolute.path, p.basename(entity.path)));
        await newDirectory.create();
        await directory(entity.absolute, newDirectory);
      } else if (entity is File) {
        await entity.copy(p.join(destination.path, p.basename(entity.path)));
      }
    }
  }

  static Future<void> file(File source, Directory destination) async {
    await source.copy(p.join(destination.path, p.basename(source.path)));
  }

  static Future<void> list(List<String> paths, Directory destination) async {
    for (var path in paths) {
      if (await File(path).exists()) {
        await Copy.file(File(path), destination);
      } else if (await Directory(path).exists()) {
        var newDirectory =
            Directory(p.join(destination.absolute.path, p.basename(path)));
        await newDirectory.create();
        await Copy.directory(Directory(path), newDirectory);
      }
    }
  }
}
