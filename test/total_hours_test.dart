import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/utilities/calculate_total_hours.dart';
import 'package:flutter_dtr_app/core/utilities/double_to_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculate Total Hours', () {
    test('Total Hours Duration', () {
      TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 30);
      TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

      double totalHours = calculateTotalHours(start: startTime, end: endTime);
      expect(totalHours, 8.5);
    });

    test('Total Hours Duration from Double to String Time', () {
      TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 30);
      TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

      double totalHours = calculateTotalHours(start: startTime, end: endTime);

      String timeDuration = convertDoubleToTime(totalHours);
      expect(timeDuration, '8hrs 30mins');
    });

    test('String Time Singular', () {
      TimeOfDay startTime = const TimeOfDay(hour: 1, minute: 1);
      TimeOfDay endTime = const TimeOfDay(hour: 2, minute: 2);

      double totalHours = calculateTotalHours(start: startTime, end: endTime);

      String timeDuration = convertDoubleToTime(totalHours);
      expect(timeDuration, '1hr 1min');
    });

    test('String Time Plural', () {
      TimeOfDay startTime = const TimeOfDay(hour: 1, minute: 1);
      TimeOfDay endTime = const TimeOfDay(hour: 5, minute: 5);

      double totalHours = calculateTotalHours(start: startTime, end: endTime);

      String timeDuration = convertDoubleToTime(totalHours);
      expect(timeDuration, '4hrs 4mins');
    });

    test('Show Only Minutes', () {
      TimeOfDay startTime1 = const TimeOfDay(hour: 0, minute: 1);
      TimeOfDay endTime1 = const TimeOfDay(hour: 0, minute: 2);

      double totalHours1 = calculateTotalHours(start: startTime1, end: endTime1);

      String timeDuration1 = convertDoubleToTime(totalHours1);
      expect(timeDuration1, '1min');

      TimeOfDay startTime2 = const TimeOfDay(hour: 0, minute: 1);
      TimeOfDay endTime2 = const TimeOfDay(hour: 0, minute: 5);

      double totalHours2 = calculateTotalHours(start: startTime2, end: endTime2);

      String timeDuration2 = convertDoubleToTime(totalHours2);
      expect(timeDuration2, '4mins');
    });

    test('Show Only Hours', () {
      TimeOfDay startTime1 = const TimeOfDay(hour: 1, minute: 0);
      TimeOfDay endTime1 = const TimeOfDay(hour: 2, minute: 0);

      double totalHours1 = calculateTotalHours(start: startTime1, end: endTime1);

      String timeDuration1 = convertDoubleToTime(totalHours1);
      expect(timeDuration1, '1hr');

      TimeOfDay startTime2 = const TimeOfDay(hour: 1, minute: 0);
      TimeOfDay endTime2 = const TimeOfDay(hour: 5, minute: 0);

      double totalHours2 = calculateTotalHours(start: startTime2, end: endTime2);

      String timeDuration2 = convertDoubleToTime(totalHours2);
      expect(timeDuration2, '4hrs');
    });
  });
}
