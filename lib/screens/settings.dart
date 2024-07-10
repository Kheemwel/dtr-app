import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/time_picker_dialog.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? selectedDateFormat;
  String? selectedTimeFormat;

  late TimeOfDay _scheduleStart = const TimeOfDay(hour: 8, minute: 0);
  late TimeOfDay _scheduleEnd = const TimeOfDay(hour: 17, minute: 0);
  late TimeOfDay _breakTimeStart = const TimeOfDay(hour: 12, minute: 0);
  late TimeOfDay _breakTimeEnd = const TimeOfDay(hour: 13, minute: 0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        _formatSelection(
          label: 'Date Format',
          items: dateFormats,
          onSelected: (selected) => setState(() {
            selectedDateFormat = selected;
          }),
        ),
        const SizedBox(
          height: 20,
        ),
        _formatSelection(
          label: 'Time Format',
          items: timeFormats,
          onSelected: (selected) => setState(() {
            selectedTimeFormat = selected;
          }),
        ),
        const SizedBox(
          height: 40,
        ),
        buildRegularText(context,
            'Set the daily and break time schedule as they are essential for calculating your work hours',
            color: palette['disabled']),
        const SizedBox(
          height: 20,
        ),
        _configureDailySchedule(context),
        const SizedBox(
          height: 20,
        ),
        _configureBreakTimeSchedule(context),
        const SizedBox(
          height: 75,
        ),
        _clearAllDataButton(),
      ],
    );
  }

  Column _configureDailySchedule(BuildContext context) {
    return _configureTimeSchedule(
        context: context,
        mainLabel: 'Daily Schedule',
        startTimeLabel: 'Daily Schedule Start',
        startTimeShedule: _scheduleStart,
        endTimeLabel: 'Daily Schedule End',
        endTimeSchedule: _scheduleEnd,
        onSave: (start, end) {
          setState(() {
            _scheduleStart = start;
            _scheduleEnd = end;
          });
        });
  }

  Column _configureBreakTimeSchedule(BuildContext context) {
    return _configureTimeSchedule(
        context: context,
        mainLabel: 'Break Time Schedule',
        startTimeLabel: 'Break Time Start',
        startTimeShedule: _breakTimeStart,
        endTimeLabel: 'Break Time End',
        endTimeSchedule: _breakTimeEnd,
        onSave: (start, end) {
          setState(() {
            _breakTimeStart = start;
            _breakTimeEnd = end;
          });
        });
  }

  Column _scheduleTimePicker(BuildContext context,
      {required String label,
      required TimeOfDay time,
      required Function(TimeOfDay selectedTime) onTimePicked}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(context, label),
        TextButton(
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
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
                  child: buildRegularText(context, time.format(context),
                      fontSize: 16)),
            ],
          ),
        )
      ],
    );
  }

  Column _configureTimeSchedule({
    required BuildContext context,
    required String mainLabel,
    required String startTimeLabel,
    required TimeOfDay startTimeShedule,
    required String endTimeLabel,
    required TimeOfDay endTimeSchedule,
    required Function(TimeOfDay start, TimeOfDay end) onSave,
  }) {
    var totalHours = endTimeSchedule.hour - startTimeShedule.hour;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(context, mainLabel),
        TextButton(
          onPressed: () async {
            await _configureTimeScheduleDialog(context, startTimeShedule,
                endTimeSchedule, startTimeLabel, endTimeLabel, onSave);
          },
          style: TextButton.styleFrom(
              backgroundColor: palette['inputs'],
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
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
                context,
                '${startTimeShedule.format(context)} - ${endTimeSchedule.format(context)}',
                fontSize: 16,
              )),
              buildRegularText(
                  context, '${totalHours}hr${totalHours > 1 ? 's' : ''}',
                  fontSize: 16),
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
      Function(TimeOfDay start, TimeOfDay end) onSave) async {
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
                      time: startTime, onTimePicked: (TimeOfDay selectedTime) {
                    setState(() {
                      startTime = selectedTime;
                    });
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  _scheduleTimePicker(context,
                      label: endTimeLabel,
                      time: endTime, onTimePicked: (TimeOfDay selectedTime) {
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
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: buildRegularText(context, 'Cancel',
                                fontSize: 20)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: palette['secondary'],
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0)),
                            onPressed: () {
                              Navigator.pop(context, {
                                'start': startTime,
                                'end': endTime,
                              });
                            },
                            child: buildButtonText(context, 'Save')),
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

  Column _formatSelection(
      {required String label,
      required Map<String, String> items,
      required Function(String? selected) onSelected}) {
    List<String> itemKeys = items.keys.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(context, label),
        Container(
          decoration: BoxDecoration(
              color: palette['inputs'],
              borderRadius: BorderRadius.circular(10)),
          child: DropdownMenu<String>(
            expandedInsets: EdgeInsets.zero,
            trailingIcon: Icon(
              applyTextScaling: false,
              Icons.keyboard_arrow_down_rounded,
              color: palette['icons'],
              size: 16,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: palette['icons'],
              size: 16,
            ),
            textStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
            initialSelection: itemKeys.first,
            requestFocusOnTap: false,
            onSelected: (String? selectedItem) {
              onSelected(selectedItem);
            },
            dropdownMenuEntries:
                itemKeys.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: items[value]!,
                labelWidget: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100),
                  child: buildRegularText(context, items[value]!, fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  TextButton _clearAllDataButton() {
    return TextButton(
        onPressed: () => _confirmationDialog(),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: palette['danger'],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(
          children: [
            Expanded(child: buildTitleText(context, 'Clear All Data')),
            SvgPicture.asset(
              iconDelete,
              width: 20,
              height: 20,
            )
          ],
        ));
  }

  Future<String?> _confirmationDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildHeading3Text(context, 'Clear All Data'),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Are you sure you want to clear all the data of the application?',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: buildRegularText(context, 'No', fontSize: 20)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: palette['secondary'],
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: buildButtonText(context, 'Yes')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
