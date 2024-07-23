import 'package:flutter_dtr_app/core/api/double_api.dart';

/// Convert the double or int hours into time
String convertDoubleToTime(double totalHours) {
  // Ensure positive value (handle negative values)
  final double adjustedHours = totalHours < 0 ? totalHours + 24 : totalHours;

  final int hours = adjustedHours.floor(); // Truncate to whole hours
  final double minutes = ((adjustedHours * 60) % 60); // Calculate remaining minutes

  final String hoursText = hours > 0 ? '${hours}hr${hours > 1 ? 's' : ''}' : '';
  final String space = hours > 0 && minutes > 0 ? ' ' : '';
  final String minuteText =
      minutes > 0 ? '${minutes.formatToString()}min${minutes > 1 ? 's' : ''}' : '';

  return '$hoursText$space$minuteText'; // Formatted string for hours and minutes
}
