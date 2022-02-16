class StringMatch {
  final int index;
  final int length;

  StringMatch({required this.index, required this.length});

  @override
  String toString() {
    return 'Index: $index, length: $length';
  }
}
