import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/dialogs/text_input_dialog.dart';
import 'package:lucidum_legalis/dialogs/yes_no_dialog.dart';
import 'package:lucidum_legalis/utils/constants.dart';
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

  static Future<void> file(
      File source, Directory destination, BuildContext context) async {
    File dest = File(p.join(destination.path, p.basename(source.path)));

    while (await dest.exists()) {
      final replace = await YesNoDialog.show(
        context: context,
        title: 'Replace File?'.tr(),
        description: 'The destination already has a file named {}. Replace it?'
            .tr(args: [p.basename(dest.path)]),
      );
      if (replace) {
        break;
      }

      final newName = await TextInputDialog.show(
        context: context,
        defaultText: p.basename(source.path),
        title: 'Enter a new name for {}'.tr(args: [p.basename(source.path)]),
      );
      if (newName == null || newName.isEmpty) {
        return;
      }

      dest = File(p.join(destination.path, p.basename(newName)));
    }
    await source.copy(dest.path);
  }

  static Future<void> list(
      List<String> paths, Directory destination, BuildContext context) async {
    for (var path in paths) {
      if (await File(path).exists()) {
        await Copy.file(File(path), destination, context);
      } else if (await Directory(path).exists()) {
        var newDirectory =
            Directory(p.join(destination.absolute.path, p.basename(path)));
        await newDirectory.create();
        await Copy.directory(Directory(path), newDirectory);
      }
    }
  }
}

class IconUtils {
  static Widget clientIcon(ClientType type) {
    switch (type) {
      case ClientType.person:
        return AppIcons.client;
      case ClientType.company:
        return AppIcons.clientCompany;
    }
  }

  static Widget clientSettingsIcon(ClientType type) {
    switch (type) {
      case ClientType.person:
        return AppIcons.clientSettings;
      case ClientType.company:
        return AppIcons.clientCompanySettings;
    }
  }

  static Widget lawsuiteIcon(LawsuiteState state) {
    switch (state) {
      case LawsuiteState.open:
        return AppIcons.lawsuiteOpened;
      case LawsuiteState.closed:
        return AppIcons.lawsuiteClosed;
      case LawsuiteState.waiting:
        return AppIcons.lawsuiteWaiting;
      case LawsuiteState.requiresAttention:
        return AppIcons.lawsuiteAttention;
    }
  }
}

class ListUtils {
  static int findMatches(List<String> l1, List<String> l2) {
    var matches = 0;
    for (var e1 in l1) {
      for (var e2 in l2) {
        if (e1.contains(e2) || e1 == e2) {
          matches++;
        }
      }
    }

    return matches;
  }
}
