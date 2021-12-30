import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Fonts {
  static const logo = GoogleFonts.parisienne;
}

class App {
  static const title = 'Lucidum Legalis';
  static const companyName = 'Fr0sk Labs';

  static const windowMinSize = Size(900, 600);
}

class Widgets {
  static const largeButtonWidth = 100.0;
}

class Locales {
  static const en = Locale('en');
  static const pt = Locale('pt', 'PT');
}

class AppIcons {
  static const add = Icon(MdiIcons.plusCircle);
  static const edit = Icon(MdiIcons.pencil);
  static const save = Icon(MdiIcons.contentSave);
  static const delete = Icon(MdiIcons.trashCan);

  static const client = Icon(MdiIcons.account);
  static const clientCompany = Icon(MdiIcons.officeBuilding);
  static const clientSettings = Icon(MdiIcons.accountCog);
  static const clientCompanySettings = Icon(MdiIcons.officeBuildingCog);
  static const addClient = Icon(MdiIcons.accountPlus);

  static const lawsuite = Icon(MdiIcons.fileDocumentOutline);
  static const lawsuiteOpened = Icon(MdiIcons.fileDocumentOutline);
  static const lawsuiteWaiting = Icon(MdiIcons.fileClockOutline);
  static const lawsuiteClosed = Icon(MdiIcons.fileCertificateOutline);
  static const lawsuiteAttention = Icon(MdiIcons.fileAlertOutline);
  static const addLawsuite = Icon(MdiIcons.filePlus);
  static const lawsuiteSettings = Icon(MdiIcons.fileCog);

  static const information = Icon(MdiIcons.information);
  static const files = Icon(MdiIcons.folder);
  static const notes = Icon(MdiIcons.noteMultiple);
  static const addNnote = Icon(MdiIcons.notePlus);
  static const loading = Icon(MdiIcons.loading);
  static const close = Icon(MdiIcons.close);
  static const settings = Icon(MdiIcons.cog);
  static const back = Icon(MdiIcons.arrowLeft);
  static const folder = Icon(MdiIcons.folder);
  static const fileUnkown = Icon(MdiIcons.fileQuestion);
  static const fileAdd = Icon(MdiIcons.filePlus);
  static const fileUpload = Icon(MdiIcons.fileUpload);
  static const copy = Icon(MdiIcons.contentCopy);
  static const cut = Icon(MdiIcons.contentCut);
  static const paste = Icon(MdiIcons.contentPaste);
  static const notification = Icon(MdiIcons.bell);

  static const fileWordColored = Icon(
    MdiIcons.fileWord,
    color: Colors.indigo,
  );
  static const fileExcelColored = Icon(
    MdiIcons.fileExcel,
    color: Colors.green,
  );
  static const filePowerpointColored = Icon(
    MdiIcons.filePowerpoint,
    color: Colors.orange,
  );
  static const filePdfColored = Icon(
    MdiIcons.filePdfBox,
    color: Colors.red,
  );
  static const fileImageColored = Icon(
    MdiIcons.fileImage,
    color: Colors.cyan,
  );
  static const fileMusicColored = Icon(
    MdiIcons.fileMusic,
    color: Colors.lightBlue,
  );
  static const folderColored = Icon(
    MdiIcons.folder,
    color: Colors.amber,
  );
  static const folderAddColored = Icon(
    MdiIcons.folderPlus,
    color: Colors.amber,
  );
  static const folderOpenColored = Icon(
    MdiIcons.folderOpen,
    color: Colors.amber,
  );
}

class Mappings {
  static const filesIcons = {
    '.doc': AppIcons.fileWordColored,
    '.docx': AppIcons.fileWordColored,
    '.xls': AppIcons.fileExcelColored,
    '.xlsx': AppIcons.fileExcelColored,
    '.ppt': AppIcons.filePowerpointColored,
    '.pptx': AppIcons.filePowerpointColored,
    '.pdf': AppIcons.filePdfColored,
    '.png': AppIcons.fileImageColored,
    '.jpg': AppIcons.fileImageColored,
    '.bmp': AppIcons.fileImageColored,
    '.mp3': AppIcons.fileMusicColored,
    '.wav': AppIcons.fileMusicColored,
  };
}
