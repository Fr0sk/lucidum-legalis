import 'package:lucidum_legalis/data/match.dart';

extension DateTimeExt on DateTime {
  DateTime get endDay => DateTime(year, month, day, 23, 59, 59);
}

extension SearchExt on String {
  List<StringMatch> search(String pattern, {matchCase = false}) {
    var i = pattern.length;
    var indexFound = -1;

    // Find pattern
    while (i >= 0 && indexFound == -1) {
      i--;
      indexFound = matchCase
          ? indexOf(pattern.substring(0, i + 1))
          : toLowerCase().indexOf(pattern.toLowerCase().substring(0, i + 1));
    }

    if (i < 0) {
      // No pattern found
      return [];
    }

    if (i == pattern.length - 1) {
      // Last pattern found
      return [StringMatch(index: indexFound, length: i + 1)];
    }

    // Found partial pattern, check for the rest
    final unmatchedStr = substring(indexFound + i + 1);
    final matches = unmatchedStr.search(pattern.substring(i + 1));
    if (matches.isNotEmpty) {
      // Found matches for the rest of the pattern
      return [StringMatch(index: indexFound, length: i + 1), ...matches];
    } else {
      return [];
    }
  }
}
