import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/time_picker_dialog.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

TextButton buildTimePickerButton(
    {required BuildContext context,
    required TimeOfDay time,
    required Function(TimeOfDay selectedTime) onTimePicked}) {
  return TextButton(
    onPressed: () async {
      final TimeOfDay? pickedTime =
          await showTimePickerDialog(context: context, initialTime: time);
      if (pickedTime != null) {
        onTimePicked(pickedTime);
      }
    },
    style: TextButton.styleFrom(
        backgroundColor: palette['inputs'],
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    child: Row(
      children: [
        Icon(
          Icons.schedule,
          color: palette['icons'],
          size: 18,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: buildRegularText(time.format(context), fontSize: 16)),
      ],
    ),
  );
}
