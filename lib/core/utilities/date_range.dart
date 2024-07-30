import 'package:flutter/material.dart';

/// Collection of methods to get various date range
class DateRange {
  /// Get the range of date of the current week of inputted date
  static DateTimeRange getThisWeek(DateTime date) {
    // Find the current Monday
    int daysSinceMonday = date.weekday - DateTime.monday;
    DateTime currentMonday = date.subtract(Duration(days: daysSinceMonday));

    // The following Sunday is 6 days after the current Monday
    DateTime followingSunday = currentMonday.add(const Duration(days: 6));

    return DateTimeRange(start: currentMonday, end: followingSunday);
  }

  /// Get the range of date of the previous week of inputted date
  static DateTimeRange getLastWeek(DateTime date) {
    // Find the previous Monday
    int daysSinceMonday = date.weekday - DateTime.monday;
    DateTime previousMonday = date.subtract(Duration(days: daysSinceMonday + 7));

    // The following Sunday is 6 days after the previous Monday
    DateTime previousSunday = previousMonday.add(const Duration(days: 6));

    return DateTimeRange(start: previousMonday, end: previousSunday);
  }

  /// Get the first date of the current month of inputted date
  static DateTime getThisMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get the first date of the current year of inputted date
  static DateTime getThisYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
}
