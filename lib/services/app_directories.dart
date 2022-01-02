import 'dart:io';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDirectories {
  static Future<void> ensureInitialized() async {
    _appDocDir = Directory(
        p.join((await getApplicationDocumentsDirectory()).path, App.title));
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
  static Directory get lawsuitesDir =>
      Directory('${_appDocDir.path}/lawsuites');

  static Directory getLawsuiteDir({Lawsuite? lawsuite, int? id}) {
    assert(lawsuite != null || id != null);
    id = id ?? lawsuite?.id;
    return Directory('${lawsuitesDir.path}/$id');
  }

  static Directory getRuntimeDir() =>
      Directory(p.dirname(Platform.resolvedExecutable));

  static Directory getUpdateDir() =>
      Directory(p.join(p.dirname(Platform.resolvedExecutable), 'Update'));

  static File getUploadFile() =>
      File(p.join(p.dirname(Platform.resolvedExecutable), 'update.zip'));
}
