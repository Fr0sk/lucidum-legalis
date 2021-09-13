import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/services/app_settings.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static final _USER_FILE = 'user.json';

  static Directory getUserDir(String username) {
    return Directory('${AppSettings().usersDir}/users/$username');
  }

  static File getUserFile(String username) {
    return File('${getUserDir(username).path}/$_USER_FILE');
  }

  static Directory getClientsDir(String username) {
    return Directory('${getUserDir(username).path}/clients');
  }

  static Directory getLawsuitesDir(String username) {
    return Directory('${getUserDir(username).path}/lawsuites');
  }

  static Directory getTemplatesDir(String username) {
    return Directory('${getUserDir(username).path}/templates');
  }

  static Directory getClientTemplatesDir(String username) {
    return Directory('${getTemplatesDir(username).path}/clients');
  }

  static Directory getLawsuiteTemplatesDir(String username) {
    return Directory('${getTemplatesDir(username).path}/lawsuites');
  }

  static Directory getGlobalTemplatesDir(String username) {
    return Directory('${getTemplatesDir(username).path}/global');
  }

  final String username;
  final String name;
  @JsonKey(ignore: true)
  String password;
  @JsonKey(ignore: true)
  final UserDatabase db;

  User({required this.username, required this.name, this.password = ''})
      : db = UserDatabase(
            userFolder: getUserDir(username).path, password: password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Directory get userDir => getUserDir(username);

  Directory get clientsDir => getClientsDir(username);

  Directory get lawsuitesDir => getLawsuitesDir(username);

  Directory get clientTemplatesDir => getClientTemplatesDir(username);

  Directory get lawsuiteTemplatesDir => getLawsuiteTemplatesDir(username);

  Directory get globalTemplatesDir => getGlobalTemplatesDir(username);

  Directory getClientDir({Client? client, int? id}) {
    assert(client != null || id != null);
    id = id ?? client?.id;
    return Directory('${clientsDir.path}/$id');
  }

  Directory getLawsuiteDir(Lawsuite lawsuite) =>
      Directory('${lawsuitesDir.path}/${lawsuite.id}');

  File get userFile => getUserFile(username);

  Future<void> createDirectories() async {
    await clientsDir.create(recursive: true);
    await lawsuitesDir.create(recursive: true);
    await clientTemplatesDir.create(recursive: true);
    await lawsuiteTemplatesDir.create(recursive: true);
    await globalTemplatesDir.create(recursive: true);
  }
}
