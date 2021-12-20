import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/tab_state.dart';

abstract class TabBodyBase<T> extends StatelessWidget {
  final TabState<T> state;

  const TabBodyBase({required this.state, Key? key}) : super(key: key);
}
