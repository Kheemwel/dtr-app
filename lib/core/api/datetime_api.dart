import 'package:intl/intl.dart';

extension DateToString on DateTime {
  /// Format DateTime to a string using the provided format
  String formatToString({String format = 'MM/dd/yyyy'}) {
    return DateFormat(format).format(this);
  }
}
