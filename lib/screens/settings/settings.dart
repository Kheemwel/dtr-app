import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/configure_time_schedule.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
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
          setState(() {
            _scheduleStart = start;
            _scheduleEnd = end;
          });
        });
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
          setState(() {
            _breakTimeStart = start;
            _breakTimeEnd = end;
          });
        });
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
        buildTitleText(label),
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
                  child: buildRegularText(items[value]!, fontSize: 14),
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
                        child: buildRegularText('No', fontSize: 20)),
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
