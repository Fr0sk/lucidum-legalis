import 'dart:ffi';
import 'dart:io';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:sqlite3/open.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static bool _setupDone = false;

  static void _setup() {
    if (!_setupDone) {
      open.overrideFor(OperatingSystem.windows, _openOnWindows);
      _setupDone = true;
    }
  }

  static DynamicLibrary _openOnWindows() {
    //final dll = File('${Directory.current}/sqlite3.dll');
    final dll = File('sqlite3.dll');
    return DynamicLibrary.open(dll.path);
  }

  static LazyDatabase openConnection(Directory dbFolder) {
    moorRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    _setup();
    return LazyDatabase(() {
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return VmDatabase(file);
    });
  }
}
