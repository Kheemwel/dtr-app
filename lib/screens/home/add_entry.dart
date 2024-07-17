import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/back_button.dart';
import 'package:flutter_dtr_app/widgets/configure_time_schedule.dart';
import 'package:flutter_dtr_app/widgets/date_picker_button.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/time_picker_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key, required this.date});

  final DateTime date;

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  late DateTime _startDate = widget.date;
  late DateTime _endDate = widget.date;

  late TimeOfDay _startTime = const TimeOfDay(hour: 17, minute: 0);
  late TimeOfDay _endTime = const TimeOfDay(hour: 6, minute: 0);
  late TimeOfDay _breakTimeStart = const TimeOfDay(hour: 12, minute: 0);
  late TimeOfDay _breakTimeEnd = const TimeOfDay(hour: 13, minute: 0);

  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent the save button to move on the top of keyboard when inputing notes
      appBar: AppBar(
        leading: buildBackButton(context: context, size: 24),
        title: buildHeading1Text('Add Entry'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            children: [
              _configureStartDateTime(),
              const SizedBox(
                height: 20,
              ),
              _configureEndDateTime(),
              const SizedBox(
                height: 20,
              ),
              _configureBreakTime(context),
              const SizedBox(
                height: 20,
              ),
              _inputNotes(context)
            ],
          ),
          Positioned(
              right: 20,
              left: 20,
              bottom: 30,
              child: buildTextButtonLarge('Save', onPressed: () {}))
        ],
      ),
    );
  }

  Column _inputNotes(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText('Notes'),
        Container(
          height: 100,
          decoration: BoxDecoration(
              color: palette['inputs'],
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _notes = value;
              });
            },
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type here...',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: palette['disabled'], fontSize: 16)),
          ),
        )
      ],
    );
  }

  Column _configureBreakTime(BuildContext context) {
    return buildTimeScheduleConfiguration(
      context: context,
      mainLabel: 'BreakTime',
      startTimeLabel: 'Start Break Time',
      startTimeShedule: _breakTimeStart,
      endTimeLabel: 'End Break Time',
      endTimeSchedule: _breakTimeEnd,
      onSave: (start, end) {
        setState(() {
          _breakTimeStart = start;
          _breakTimeEnd = end;
        });
      },
    );
  }

  Column _configureEndDateTime() {
    return _configureDateTime(
      label: 'End',
      date: _endDate,
      time: _endTime,
      onDatePicked: (selectedDate) {
        setState(() {
          _endDate = selectedDate;
        });
      },
      onTimePicked: (selectedTime) {
        setState(() {
          _endTime = selectedTime;
        });
      },
    );
  }

  Column _configureStartDateTime() {
    return _configureDateTime(
      label: 'Start',
      date: _startDate,
      time: _startTime,
      onDatePicked: (selectedDate) {
        setState(() {
          _startDate = selectedDate;
        });
      },
      onTimePicked: (selectedTime) {
        setState(() {
          _startTime = selectedTime;
        });
      },
    );
  }

  Column _configureDateTime({
    required String label,
    required DateTime date,
    required TimeOfDay time,
    required Function(DateTime selectedDate) onDatePicked,
    required Function(TimeOfDay selectedTime) onTimePicked,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText(label),
        Row(
          children: [
            Expanded(
              child: buildDatePickerButton(
                context: context,
                date: date,
                onDatePicked: onDatePicked,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: buildTimePickerButton(
                context: context,
                time: time,
                onTimePicked: onTimePicked,
              ),
            ),
          ],
        )
      ],
    );
  }
}
