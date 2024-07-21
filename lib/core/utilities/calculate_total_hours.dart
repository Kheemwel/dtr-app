import 'package:flutter/material.dart';

/// Calculate the total hours between two TimeOfDays
double calculateTotalHours({required TimeOfDay start, required TimeOfDay end}) {
  double totalHours = end.hour - start.hour + (end.minute - start.minute) / 60.0;
  return totalHours = totalHours < 0 ? totalHours + 24 : totalHours;
}
