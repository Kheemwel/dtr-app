import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

Future<TimeOfDay?> showTimePickerDialog(
    {required BuildContext context, required TimeOfDay initialTime}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: palette[
                'primary']!, // Color for time hand and time input background
            secondary: palette['icons']!, // Color for AM/PM input background
          ),
        ),
        child: child!,
      );
    },
  );
}
