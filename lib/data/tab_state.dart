import 'package:flutter/widgets.dart';

class TabState<T> {
  final int id;
  final Stream<T> dataStream;
  final dataNotifier = ValueNotifier<T?>(null);
  final ValueNotifier<bool> editNotifier;

  TabState({required this.dataStream, required this.id, bool edit = false})
      : editNotifier = ValueNotifier(edit) {
    dataStream.listen((event) {
      dataNotifier.value = event;
      //dataNotifier.notifyListeners();
    });
  }

  set edit(bool edit) {
    editNotifier.value = edit;
    //editNotifier.notifyListeners();
  }

  void toggleEdit() => edit = !editNotifier.value;

  bool get edit => editNotifier.value;

  /*@override
  bool operator ==(o) => o is TabState<T> && o.id == id;

  @override
  int get hashCode => '${T.runtimeType.toString()}$id'.hashCode;*/
}
