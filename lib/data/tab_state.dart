import 'package:flutter/widgets.dart';

class TabState<T> extends ChangeNotifier {
  final Stream<T> data;
  final int id;
  bool _edit;

  TabState({required this.data, required this.id, bool edit = false})
      : _edit = edit;

  set edit(bool edit) {
    _edit = edit;
    notifyListeners();
  }

  void toggleEdit() => edit = !_edit;

  bool get edit => _edit;

  /*@override
  bool operator ==(o) => o is TabState<T> && o.id == id;

  @override
  int get hashCode => '${T.runtimeType.toString()}$id'.hashCode;*/
}
