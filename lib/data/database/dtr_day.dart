import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DTRDay {
  final DateTime? date;
  final TimeOfDay timeIn;
  final TimeOfDay timeOut;

  DTRDay({
    this.date, // Nullable DateTime
    this.timeIn = const TimeOfDay(hour: 0, minute: 0),
    this.timeOut = const TimeOfDay(hour: 0, minute: 0),
  });

  String getFormattedDate() {
    // Format the date using DateFormat
    return DateFormat('MMMM d, yyyy').format(date!);
  }

  factory DTRDay.fromJson(Map<String, dynamic> json) {
    return DTRDay(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      timeIn: _parseTimeOfDay(json['timeIn']),
      timeOut: _parseTimeOfDay(json['timeOut']),
    );
  }

  static TimeOfDay _parseTimeOfDay(String? timeString) {
    if (timeString == null) return const TimeOfDay(hour: 0, minute: 0);
    List<String> parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'timeIn': '${timeIn.hour}:${timeIn.minute}',
      'timeOut': '${timeOut.hour}:${timeOut.minute}',
    };
  }
}
