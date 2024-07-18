import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

Future<TimeOfDay?> showTimePickerDialog({
  required BuildContext context,
  required TimeOfDay initialTime,
  required bool use24HourFormat,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(alwaysUse24HourFormat: use24HourFormat),
        child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: palette[
                  'primary']!, // Color for time hand and time input background
              secondary: palette['icons']!, // Color for AM/PM input background
            ),
          ),
          child: child!,
        ),
      );
    },
  );
}
