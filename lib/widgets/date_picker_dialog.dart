import 'package:flutter/material.dart';

Future<DateTime?> showDatePickerDialog({required BuildContext context}) {
  return showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
}
