import 'dart:convert';

import 'package:flutter/material.dart';

import 'dtr_day.dart';

class DTR {
  final TimeOfDay lunchStart;
  final TimeOfDay lunchEnd;
  final TimeOfDay scheduleStart;
  final TimeOfDay scheduleEnd;

  final List<List<DTRDay>> dtrWeeks;

  DTR({
    required this.lunchStart,
    required this.lunchEnd,
    required this.scheduleStart,
    required this.scheduleEnd,
    required this.dtrWeeks,
  });

  factory DTR.fromJson(Map<String, dynamic> json) {
  List<List<DTRDay>> dtrWeeks = [];
  if (json['dtrWeeks'] != null) {
    json['dtrWeeks'].forEach((week) {
      List<DTRDay> days = [];
      for (var day in (week as List)) {
        days.add(DTRDay.fromJson(day));
      }
      dtrWeeks.add(days);
    });
  }

  return DTR(
    lunchStart: _parseTimeOfDay(json['lunchStart']),
    lunchEnd: _parseTimeOfDay(json['lunchEnd']),
    scheduleStart: _parseTimeOfDay(json['scheduleStart']),
    scheduleEnd: _parseTimeOfDay(json['scheduleEnd']),
    dtrWeeks: dtrWeeks,
  );
}

static TimeOfDay _parseTimeOfDay(String? timeString) {
  if (timeString == null) return const TimeOfDay(hour: 0, minute: 0);
  List<String> parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}


  Map<String, dynamic> toJson() {
    return {
      'lunchStart': '${lunchStart.hour}:${lunchStart.minute}',
      'lunchEnd': '${lunchEnd.hour}:${lunchEnd.minute}',
      'scheduleStart': '${scheduleStart.hour}:${scheduleStart.minute}',
      'scheduleEnd': '${scheduleEnd.hour}:${scheduleEnd.minute}',
      'dtrWeeks': dtrWeeks.map((week) => week.map((day) => day.toJson()).toList()).toList(),
    };
  }
}

class JSON {
  static String stringify(Map<String, dynamic> json) {
    return jsonEncode(json);
  }

  static Map<String, dynamic> toMap(String jsonString) {
    return jsonDecode(jsonString);
  }
}
