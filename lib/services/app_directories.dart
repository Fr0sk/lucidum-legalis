import 'dart:io';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDirectories {
  static Future<void> ensureInitialized() async {
    final portableFile = File('portable');
    if (await portableFile.exists()) {
      _appDocDir = Directory(p.join(runtimeDir.path, 'db'));
    } else {
      _appDocDir = Directory(
          p.join((await getApplicationDocumentsDirectory()).path, App.title));
    }
  }

  static late final Directory _appDocDir;
  static Directory get appDocDir => _appDocDir;

  // Clients related directories
  static Directory get clientsDir => Directory('${_appDocDir.path}/clients');

  static Directory getClientDir({Client? client, int? id}) {
    assert(client != null || id != null);
    id = id ?? client?.id;
    return Directory('${clientsDir.path}/$id');
  }

  // Lawsuites related directories
  static Directory get lawsuitsDir => Directory('${_appDocDir.path}/lawsuites');

  static Directory getLawsuiteDir({Lawsuite? lawsuite, int? id}) {
    assert(lawsuite != null || id != null);
    id = id ?? lawsuite?.id;
    return Directory('${lawsuitsDir.path}/$id');
  }

  static Directory get runtimeDir =>
      Directory(p.dirname(Platform.resolvedExecutable));

  static File get updatePakage => File(p.join(runtimeDir.path, 'update.pkg'));

  static File get updater => File(
      p.join(runtimeDir.path, Platform.isWindows ? 'updater.exe' : 'updater'));
}
