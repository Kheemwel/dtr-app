import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtensions on TimeOfDay {
  /// Convert TimeOfDay to DateTime for formatting
  DateTime _toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  /// Format TimeOfDay to a string using the provided format
  String formatToString({String format = 'HH:mm'}) {
    final dateTime = _toDateTime();
    return DateFormat(format).format(dateTime);
  }

  /// Check if the time is after the inputted TimeOfDay
  bool isAfter(TimeOfDay other) {
    final now = DateTime.now();
    final thisDateTime = DateTime(now.year, now.month, now.day, hour, minute);
    final otherDateTime = DateTime(now.year, now.month, now.day, other.hour, other.minute);

    return thisDateTime.isAfter(otherDateTime);
  }

  /// Check if the time is before the inputted TimeOfDay
  bool isBefore(TimeOfDay other) {
    final now = DateTime.now();
    final thisDateTime = DateTime(now.year, now.month, now.day, hour, minute);
    final otherDateTime = DateTime(now.year, now.month, now.day, other.hour, other.minute);

    return thisDateTime.isBefore(otherDateTime);
  }
}
