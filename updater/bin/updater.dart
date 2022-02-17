import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:progress_bar/progress_bar.dart';

void main(List<String> arguments) async {
  try {
    await extractUpdate();
  } catch (_) {
  } finally {
    await launchApp();
  }
}

Future<void> extractUpdate() async {
  final updatePkg = File('update.pkg');
  final bytes = await updatePkg.readAsBytes();
  final archive = ZipDecoder().decodeBytes(bytes);
  print('Installing Update');
  final bar = ProgressBar('[:bar] :percent', total: archive.length, width: 15);

  for (final file in archive) {
    final filename = file.name;

    // Skip own executable
    if (filename == p.basename(Platform.resolvedExecutable)) {
      continue;
    }

    if (file.isFile) {
      final out = File(filename);
      await out.create(recursive: true);
      await out.writeAsBytes(file.content);
    } else {
      await Directory(filename).create(recursive: true);
    }
    bar.tick();
  }
  await updatePkg.delete();
}

Future<void> launchApp() async {
  if (Platform.isWindows) {
    await Process.start('lucidum_legalis.exe', ['showReleaseNotes'],
        mode: ProcessStartMode.detached);
  } else {
    print('Platform not supported');
    await Future.delayed(Duration(seconds: 10));
  }
}
