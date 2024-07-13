import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

Future<DateTime?> showDatePickerDialog({required BuildContext context}) {
  return showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: palette['primary']!, // Color for selected day
            secondary: palette['icons']!,
          ),
        ),
        child: child!,
      );
    },
  );
}
