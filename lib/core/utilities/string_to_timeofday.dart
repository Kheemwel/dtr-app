import 'package:flutter/material.dart';

TimeOfDay? parseTimeOfDay(String formattedTime) {
  try {
    List<String> parts = formattedTime.split(':');
    if (parts.length != 2) return null; // Early return for invalid format

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return null; // Combined validation
    }

    return TimeOfDay(hour: hour, minute: minute);
  } catch (error) {
    return null;
  }
}
