import 'dart:convert';
import 'dart:io';

import 'package:lucidum_legalis/constants/app_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SettingsStorageService with _SettingsStorageService {
  static final SettingsStorageService _i = SettingsStorageService._internal();
  factory SettingsStorageService() => _i;
  SettingsStorageService._internal();

  String _usersPath;
  String _rememberedUser;

  Future<String> get usersPath async {
    await _loadIfNotLoaded();
    return _usersPath;
  }

  Future<void> setUsersPath(String newPath) async {
    _usersPath = newPath;
    await _save();
  }

  Future<String> get rememberedUser async {
    await _loadIfNotLoaded();
    return _rememberedUser;
  }

  Future<void> setRememberedUser(String username) async {
    _rememberedUser = username;
    await _save();
  }

  @override
  Future<void> _fromJson(Map<String, dynamic> json) async {
    _usersPath = json['usersPath'] ??
        p.join((await getApplicationDocumentsDirectory()).path,
            AppConstants.AppName, 'Accounts');
    _rememberedUser = json['rememberedUser'];
  }

  @override
  Map<String, dynamic> _toJson() =>
      {'usersPath': _usersPath, 'rememberedUser': _rememberedUser};
}

class _SettingsStorageService {
  static final _FILE_NAME = 'settings.json';

  bool _loaded = false;
  /*static Future<SettingsStorageService> init() async {
    final model = SettingsStorageService();
    await model._load();
    await model._save();
    return model;
  }*/

  Future<File> get _settingsFile async {
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, _FILE_NAME));
  }

  Future<void> _fromJson(Map<String, dynamic> json) async {}

  Map<String, dynamic> _toJson() => {};

  Future<void> _loadIfNotLoaded() async {
    if (!_loaded) {
      await _load();
    }
  }

  Future<void> _load() async {
    final file = await _settingsFile;
    var json = '{}';
    if (await file.exists()) {
      json = await file.readAsString();
    }
    await _fromJson(jsonDecode(json));

    _loaded = true;
  }

  Future<void> _save() async {
    final file = await _settingsFile;
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(_toJson()));
  }
}
