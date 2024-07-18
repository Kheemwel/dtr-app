import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/timeofday_api.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/core/utilities/string_to_timeofday.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/widgets/configure_time_schedule.dart';
import 'package:flutter_dtr_app/widgets/show_snackbar.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedDateFormat = SharedPref.getDateFormat();
  String _selectedTimeFormat = SharedPref.getTimeFormat();

  late bool _use24HourFormat = _selectedTimeFormat == militaryHourFormat;

  TimeOfDay _scheduleStart = parseTimeOfDay(SharedPref.getDailyScheduleStart())!;
  TimeOfDay _scheduleEnd = parseTimeOfDay(SharedPref.getDailyScheduleEnd())!;
  TimeOfDay _breakTimeStart = parseTimeOfDay(SharedPref.getBreakTimeStart())!;
  TimeOfDay _breakTimeEnd = parseTimeOfDay(SharedPref.getBreakTimeEnd())!;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        _formatSelection(
          label: 'Date Format',
          items: dateFormats,
          value: _selectedDateFormat,
          onSelected: (selected) => setState(() {
            _selectedDateFormat = selected!;
            SharedPref.setDateFormat(_selectedDateFormat);
          }),
        ),
        const SizedBox(
          height: 20,
        ),
        _formatSelection(
          label: 'Time Format',
          items: timeFormats,
          value: _selectedTimeFormat,
          onSelected: (selected) => setState(() {
            _selectedTimeFormat = selected!;
            _use24HourFormat = _selectedTimeFormat == militaryHourFormat;
            SharedPref.setTimeFormat(_selectedTimeFormat);
          }),
        ),
        const SizedBox(
          height: 40,
        ),
        buildRegularText(
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
    return buildTimeScheduleConfiguration(
      context: context,
      mainLabel: 'Daily Schedule',
      startTimeLabel: 'Daily Schedule Start',
      startTimeShedule: _scheduleStart,
      endTimeLabel: 'Daily Schedule End',
      endTimeSchedule: _scheduleEnd,
      onSave: (start, end) {
        if (start.hour > _breakTimeStart.hour) {
          showSnackBar(
              context, 'The start of daily schedule should be before the start of break time');
          return;
        }
        if (end.hour < _breakTimeEnd.hour) {
          showSnackBar(context, 'The end of daily schedule should be after the end of break time');
          return;
        }
        setState(() {
          _scheduleStart = start;
          _scheduleEnd = end;

          SharedPref.setDailyScheduleStart(_scheduleStart.formatToString());
          SharedPref.setDailyScheduleEnd(_scheduleEnd.formatToString());
        });
      },
      timeFormat: _selectedTimeFormat,
      use24HourFormat: _use24HourFormat,
    );
  }

  Column _configureBreakTimeSchedule(BuildContext context) {
    return buildTimeScheduleConfiguration(
      context: context,
      mainLabel: 'Break Time Schedule',
      startTimeLabel: 'Break Time Start',
      startTimeShedule: _breakTimeStart,
      endTimeLabel: 'Break Time End',
      endTimeSchedule: _breakTimeEnd,
      onSave: (start, end) {
        if (start.hour < _scheduleStart.hour) {
          showSnackBar(
              context, 'The start of break time should be after the start of daily schedule');
          return;
        }

        if (end.hour > _scheduleEnd.hour) {
          showSnackBar(context, 'The end of break time should be before the end of daily schedule');
          return;
        }
        setState(() {
          _breakTimeStart = start;
          _breakTimeEnd = end;

          SharedPref.setBreakTimeStart(_breakTimeStart.formatToString());
          SharedPref.setBreakTimeEnd(_breakTimeEnd.formatToString());
        });
      },
      timeFormat: _selectedTimeFormat,
      use24HourFormat: _use24HourFormat,
    );
  }

  Column _formatSelection(
      {required String label,
      required Map<String, String> items,
      required String? value,
      required Function(String? selected) onSelected}) {
    List<String> itemKeys = items.keys.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(label),
        Container(
          decoration:
              BoxDecoration(color: palette['inputs'], borderRadius: BorderRadius.circular(10)),
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
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
            initialSelection: value,
            requestFocusOnTap: false,
            onSelected: (String? selectedItem) {
              onSelected(selectedItem);
            },
            dropdownMenuEntries: itemKeys.map<DropdownMenuEntry<String>>((String val) {
              return DropdownMenuEntry<String>(
                value: val,
                label: items[val]!,
                style: ButtonStyle(
                  backgroundBuilder: (context, states, child) {
                    Color? backgroundColor;
                    if (value == val) {
                      backgroundColor = palette['primary']!;
                    } else if (states.contains(WidgetState.hovered)) {
                      backgroundColor = palette['inputs']!;
                    } else {
                      backgroundColor = Colors.white;
                    }

                    return ColoredBox(
                      color: backgroundColor,
                      child: child,
                    );
                  },
                ),
                labelWidget: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
                  child: buildRegularText(items[val]!,
                      fontSize: 14, color: value == val ? Colors.white : null),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Row(
          children: [
            Expanded(child: buildTitleText('Clear All Data')),
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
              buildHeading3Text('Clear All Data'),
              const SizedBox(
                height: 10,
              ),
              buildRegularText('Are you sure you want to clear all the data of the application?',
                  fontSize: 16, isCentered: true),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: buildTextButtonSmall('No', onPressed: () {
                      Navigator.pop(context);
                    }, inverted: true),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: buildTextButtonSmall('Yes', onPressed: () {
                      Navigator.pop(context);
                    }),
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
