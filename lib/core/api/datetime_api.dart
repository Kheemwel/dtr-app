import 'package:intl/intl.dart';

extension DateToString on DateTime {
  String format({String format = 'MM/dd/yyyy'}) {
    return DateFormat(format).format(this);
  }
}
