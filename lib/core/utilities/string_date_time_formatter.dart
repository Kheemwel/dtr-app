import 'package:flutter_dtr_app/core/api/timeofday_api.dart';
import 'package:flutter_dtr_app/core/utilities/string_to_timeofday.dart';
import 'package:intl/intl.dart';

String formatStringTime({required String timeString, required String format}) {
  try {
    return parseTimeOfDay(timeString)!.formatToString(format: format);
  } catch (error) {
    return timeString;
  }
}

String formatStringDate(
    {required String dateString, String fromFormat = 'MM/dd/yyyy', required String toFormat}) {
  try {
    final parsedTime = DateFormat(fromFormat).parseLoose(dateString);
    return DateFormat(toFormat).format(parsedTime);
  } catch (error) {
    return dateString;
  }
}
