import 'dart:collection';

import 'package:flutter/widgets.dart';

enum TabType { CLIENT, FILE }

class TabModel {
  final int id;
  final TabType type;

  TabModel({@required this.type, this.id});
}

class TabControllerModel extends ChangeNotifier {
  final List<TabModel> _tabs = [];

  UnmodifiableListView<TabModel> get items => UnmodifiableListView(_tabs);

  void _open(TabModel tab) {
    if (!_tabs.contains(tab)) {
      _tabs.add(tab);
      notifyListeners();
    }
  }

  void openNewClient() {
    _open(TabModel(type: TabType.CLIENT));
  }

  void openClient(int clientId) {
    _open(TabModel(type: TabType.CLIENT, id: clientId));
  }

  void close(TabModel tab) {
    if (_tabs.contains(tab)) {
      _tabs.remove(tab);
      notifyListeners();
    }
  }

  void openNewFile() {
    _open(TabModel(type: TabType.FILE));
  }

  void openFile(int fileId) {
    _open(TabModel(type: TabType.CLIENT, id: fileId));
  }
}
