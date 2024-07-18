import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/timeofday_api.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/show_snackbar.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/time_picker_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

Column buildTimeScheduleConfiguration({
  required BuildContext context,
  required String mainLabel,
  required String startTimeLabel,
  required TimeOfDay startTimeShedule,
  required String endTimeLabel,
  required TimeOfDay endTimeSchedule,
  required Function(TimeOfDay start, TimeOfDay end) onSave,
  required String timeFormat,
  required bool use24HourFormat,
}) {
  int totalHours = endTimeSchedule.hour - startTimeShedule.hour;
  totalHours = totalHours < 0 ? totalHours + 24 : totalHours;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTitleText(mainLabel),
      TextButton(
        onPressed: () async {
          await _configureTimeScheduleDialog(
            context,
            startTimeShedule,
            endTimeSchedule,
            startTimeLabel,
            endTimeLabel,
            onSave,
            timeFormat,
            use24HourFormat,
          );
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
            Expanded(
                child: buildRegularText(
              '${startTimeShedule.formatToString(format: timeFormat)} - ${endTimeSchedule.formatToString(format: timeFormat)}',
              fontSize: 16,
            )),
            buildRegularText('${totalHours}hr${totalHours > 1 ? 's' : ''}', fontSize: 16),
          ],
        ),
      )
    ],
  );
}

Future<void> _configureTimeScheduleDialog(
  BuildContext context,
  TimeOfDay startTimeShedule,
  TimeOfDay endTimeSchedule,
  String startTimeLabel,
  String endTimeLabel,
  Function(TimeOfDay start, TimeOfDay end) onSave,
  String timeFormat,
  bool use24HourFormat,
) async {
  final schedule = await showDialog<Map<String, TimeOfDay>>(
    context: context,
    builder: (BuildContext context) {
      TimeOfDay startTime = startTimeShedule;
      TimeOfDay endTime = endTimeSchedule;
      return StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _scheduleTimePicker(context,
                    label: startTimeLabel,
                    timeFormat: timeFormat,
                    use24HourFormat: use24HourFormat,
                    time: startTime, onTimePicked: (TimeOfDay selectedTime) {
                  if (selectedTime.hour > endTime.hour) {
                    showSnackBar(context, 'Start time should be before the end time');
                    return;
                  }
                  setState(() {
                    startTime = selectedTime;
                  });
                }),
                const SizedBox(
                  height: 20,
                ),
                _scheduleTimePicker(context,
                    label: endTimeLabel,
                    timeFormat: timeFormat,
                    use24HourFormat: use24HourFormat,
                    time: endTime, onTimePicked: (TimeOfDay selectedTime) {
                  if (selectedTime.hour < startTime.hour) {
                    showSnackBar(context, 'End time show be after the start time');
                    return;
                  }
                  setState(() {
                    endTime = selectedTime;
                  });
                }),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildTextButtonSmall('Cancel', onPressed: () {
                        Navigator.pop(context);
                      }, inverted: true),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildTextButtonSmall('Save', onPressed: () {
                        Navigator.pop(context, {
                          'start': startTime,
                          'end': endTime,
                        });
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );

  if (schedule != null) {
    onSave(schedule['start']!, schedule['end']!);
  }
}

Column _scheduleTimePicker(
  BuildContext context, {
  required String label,
  required TimeOfDay time,
  required Function(TimeOfDay selectedTime) onTimePicked,
  required String timeFormat,
  required bool use24HourFormat,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTitleText(label),
      buildTimePickerButton(
        context: context,
        time: time,
        onTimePicked: onTimePicked,
        timeFormat: timeFormat,
        use24HourFormat: use24HourFormat,
      )
    ],
  );
}
