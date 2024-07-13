import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/datetime_api.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/date_picker_dialog.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

TextButton buildDatePickerButton(
    {required BuildContext context,
    required DateTime date,
    required Function(DateTime selectedDate) onDatePicked}) {
  return TextButton(
    onPressed: () async {
      final DateTime? pickedDate = await showDatePickerDialog(context: context);
      if (pickedDate != null) {
        onDatePicked(pickedDate);
      }
    },
    style: TextButton.styleFrom(
        backgroundColor: palette['inputs'],
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    child: Row(
      children: [
        SvgPicture.asset(
          iconCalendar,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(palette['icons']!, BlendMode.srcIn),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: buildRegularText(date.format(), fontSize: 16)),
      ],
    ),
  );
}
