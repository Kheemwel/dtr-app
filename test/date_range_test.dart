import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/utilities/date_range.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test date ranges', () {
    test('Get the date range of the current week', () {
      DateTime today = DateTime(2024, 7, 30);
      DateTimeRange thisWeek = DateRange.getThisWeek(today);

      DateTime expectedDateStart = DateTime(2024, 7, 29);
      DateTime expectedDateEnd = DateTime(2024, 8, 4);

      expect(thisWeek.start, expectedDateStart);
      expect(thisWeek.end, expectedDateEnd);
    });

    test('Get the date range of the last week', () {
      DateTime today = DateTime(2024, 7, 30);
      DateTimeRange lastWeek = DateRange.getLastWeek(today);

      DateTime expectedDateStart = DateTime(2024, 7, 22);
      DateTime expectedDateEnd = DateTime(2024, 7, 28);

      expect(lastWeek.start, expectedDateStart);
      expect(lastWeek.end, expectedDateEnd);
    });

    test('Get the first date of the current month', () {
      DateTime today = DateTime(2024, 7, 30);
      DateTime thisMonth = DateRange.getThisMonth(today);

      expect(thisMonth, DateTime(2024, 7, 1));
    });

    test('Get the first date of the current year', () {
      DateTime today = DateTime(2024, 7, 30);
      DateTime thisYear = DateRange.getThisYear(today);

      expect(thisYear, DateTime(2024, 1, 1));
    });
  });
}
