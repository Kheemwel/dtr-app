import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayFormatting on TimeOfDay {
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
}
