extension DateTimeExt on DateTime {
  DateTime get endDay => DateTime(year, month, day, 23, 59, 59);
}
