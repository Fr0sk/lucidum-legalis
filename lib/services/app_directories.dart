import 'dart:io';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/services/app_settings.dart';

class AppDirectories {
  // Clients related directories
  static Directory getClientsDir() {
    return Directory('${AppSettings().usersDir}/clients');
  }

  static Directory getClientDir({Client? client, int? id}) {
    assert(client != null || id != null);
    id = id ?? client?.id;
    return Directory('${getClientsDir().path}/$id');
  }

  // Lawsuites related directories
  static Directory getLawsuitesDir() {
    return Directory('${AppSettings().usersDir}/lawsuites');
  }

  static Directory getLawsuiteDir({Lawsuite? lawsuite, int? id}) {
    assert(lawsuite != null || id != null);
    id = id ?? lawsuite?.id;
    return Directory('${getLawsuitesDir().path}/$id');
  }
}
