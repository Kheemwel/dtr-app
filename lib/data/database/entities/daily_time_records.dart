import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/utilities/calculate_total_hours.dart';
import 'package:flutter_dtr_app/core/utilities/string_to_timeofday.dart';
import 'package:flutter_dtr_app/data/database/entities/base_entity.dart';

@Entity(tableName: 'DailyTimeRecords', indices: [
  Index(value: ['dateStart'], unique: true)
])
class DailyTimeRecord extends BaseEntity {
  final String dateStart;
  final String dateEnd;
  final String startTime;
  final String endTime;
  final String breakTimeStart;
  final String breakTimeEnd;
  final String notes;

  DailyTimeRecord({
    super.id,
    required this.dateStart,
    required this.dateEnd,
    required this.startTime,
    required this.endTime,
    required this.breakTimeStart,
    required this.breakTimeEnd,
    required this.notes,
    super.updateTime,
    super.createTime,
  });

  Map toJson() => {
        'id': id,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'startTime': startTime,
        'endTime': endTime,
        'breakTimeStart': breakTimeStart,
        'breakTimeEnd': breakTimeEnd,
        'createTime': createTime,
        'notes': notes,
        'updateTIme': updateTime,
      };

  double getTotalHours() {
    double totalWorkHours = 0;

    final TimeOfDay timeStart = parseTimeOfDay(startTime)!;
    final TimeOfDay timeEnd = parseTimeOfDay(endTime)!;
    final TimeOfDay breakStart = parseTimeOfDay(breakTimeStart)!;
    final TimeOfDay breakEnd = parseTimeOfDay(breakTimeEnd)!;

    double workHours = calculateTotalHours(start: timeStart, end: timeEnd);

    double breakTimeHours = calculateTotalHours(start: breakStart, end: breakEnd);

    totalWorkHours = workHours - breakTimeHours;

    return totalWorkHours;
  }

  static double calculateAllTotalHours(
    List<DailyTimeRecord> records,
  ) {
    double totalWorkHours = 0;
    for (var record in records) {
      totalWorkHours += record.getTotalHours();
    }
    return totalWorkHours;
  }
}
