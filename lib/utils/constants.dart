import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Fonts {
  static const Logo = GoogleFonts.parisienne;
}

class App {
  static const Title = 'Lucidum Legalis';
}

class Widgets {
  static const LargeButtonWidth = 100.0;
}

class Locales {
  static const En = Locale('en');
  static const Pt = Locale('pt', 'PT');
}

class AppIcons {
  static const client = Icon(LineIcons.user);
  static const addClient = Icon(LineIcons.userPlus);
  static const lawsuite = Icon(LineIcons.fileAlt);
  static const addLawsuite = Icon(LineIcons.medicalFile);
  static const edit = Icon(LineIcons.edit);
  static const save = Icon(LineIcons.save);
  static const delete = Icon(LineIcons.alternateTrashAlt);
  static const information = Icon(LineIcons.infoCircle);
  static const files = Icon(LineIcons.folder);
  static const notes = Icon(LineIcons.stickyNote);
  static const loading = Icon(LineIcons.spinner);
  static const close = Icon(LineIcons.times);
}
