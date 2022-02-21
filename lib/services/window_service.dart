import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:window_manager/window_manager.dart';

class WindowService extends WindowListener {
  static final WindowService _instance = WindowService._internal();
  factory WindowService() => _instance;
  WindowService._internal();

  Future<void> ensureInitialized() async {
    await windowManager.setTitle(App.title);
    await windowManager.setMinimumSize(App.windowMinSize);

    if (appSettings.isWindowMaximized.value) {
      await windowManager.maximize();
    }

    windowManager.addListener(this);
  }

  /*@override
  Future<void> onWindowResize() async {
    final size = await windowManager.getSize();
    super.onWindowResize();
  }*/

  @override
  void onWindowMaximize() {
    appSettings.isWindowMaximized.value = true;
    super.onWindowMaximize();
  }

  @override
  void onWindowUnmaximize() {
    appSettings.isWindowMaximized.value = false;
    super.onWindowUnmaximize();
  }
}
