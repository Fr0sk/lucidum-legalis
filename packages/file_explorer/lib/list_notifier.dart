import 'package:flutter/material.dart';

class ListNotifier<T> extends ValueNotifier<List<T>> {
  ListNotifier(List<T> value) : super(value);

  T operator [](int index) => value[index];
  int get length => value.length;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  int indexOf(T val) => value.indexOf(val);

  T get first => value.first;

  T get last => value.last;

  bool contains(T val) => value.contains(val);

  int indexWhere(bool Function(T) test, [int start = 0]) =>
      value.indexWhere(test, start);

  Iterable<U> map<U>(U Function(T e) toElement) => value.map(toElement);

  void add(T newValue) {
    value.add(newValue);
    notifyListeners();
  }

  bool remove(T toRemove) {
    if (value.remove(toRemove)) {
      notifyListeners();
      return true;
    }
    return false;
  }

  T removeAt(int index) {
    final removed = value.removeAt(index);
    notifyListeners();
    return removed;
  }

  void replace(Iterable<T> newList) {
    value.clear();
    value.addAll(newList);
    notifyListeners();
  }
}
