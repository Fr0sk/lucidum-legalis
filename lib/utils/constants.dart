import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Fonts {
  static const logo = GoogleFonts.parisienne;
}

class App {
  static const title = 'Lucidum Legalis';
  static const windowMinSize = Size(600, 400);
}

class Widgets {
  static const largeButtonWidth = 100.0;
}

class Locales {
  static const en = Locale('en');
  static const pt = Locale('pt', 'PT');
}

class AppIcons {
  static const client = Icon(MdiIcons.account);
  static const addClient = Icon(MdiIcons.accountPlus);
  static const lawsuite = Icon(MdiIcons.fileDocument);
  static const addLawsuite = Icon(MdiIcons.filePlus);
  static const edit = Icon(MdiIcons.pencil);
  static const save = Icon(MdiIcons.contentSave);
  static const delete = Icon(MdiIcons.trashCan);
  static const information = Icon(MdiIcons.information);
  static const files = Icon(MdiIcons.folder);
  static const notes = Icon(MdiIcons.noteMultiple);
  static const addNnote = Icon(MdiIcons.notePlus);
  static const loading = Icon(MdiIcons.loading);
  static const close = Icon(MdiIcons.close);
  static const settings = Icon(MdiIcons.cog);
}