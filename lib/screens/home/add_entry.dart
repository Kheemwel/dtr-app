import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/datetime_api.dart';
import 'package:flutter_dtr_app/core/api/timeofday_api.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/core/utilities/string_to_timeofday.dart';
import 'package:flutter_dtr_app/data/database/entities/daily_time_records.dart';
import 'package:flutter_dtr_app/data/models/daily_time_records_model.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/widgets/back_button.dart';
import 'package:flutter_dtr_app/widgets/configure_time_schedule.dart';
import 'package:flutter_dtr_app/widgets/confirmation_dialog.dart';
import 'package:flutter_dtr_app/widgets/date_picker_button.dart';
import 'package:flutter_dtr_app/widgets/show_snackbar.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/time_picker_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key, required this.date});

  final DateTime date;

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  late DateTime _startDate = widget.date;
  late DateTime _endDate = widget.date.add(const Duration(days: 1));

  TimeOfDay _startTime = parseTimeOfDay(SharedPref.getDailyScheduleStart())!;
  TimeOfDay _endTime = parseTimeOfDay(SharedPref.getDailyScheduleEnd())!;
  TimeOfDay _breakTimeStart = parseTimeOfDay(SharedPref.getBreakTimeStart())!;
  TimeOfDay _breakTimeEnd = parseTimeOfDay(SharedPref.getBreakTimeEnd())!;

  String _notes = '';

  final String _dateFormat = SharedPref.getDateFormat();
  final String _timeFormat = SharedPref.getTimeFormat();
  late final bool _use24HourFormat = _timeFormat == militaryHourFormat;

  final DailyTimeRecordsModel _dailyTimeRecordsModel = DailyTimeRecordsModel();

  late bool _editMode;
  late DailyTimeRecord? _selectedRecord;

  @override
  void initState() {
    super.initState();
    String date = widget.date.formatToString();
    _editMode = _dailyTimeRecordsModel.existingDatesNotifier.value.contains(date);
    if (_editMode) {
      _getExistingRecord(date);
    }
  }

  Future<void> _getExistingRecord(String date) async {
    _selectedRecord = await _dailyTimeRecordsModel.dailyTimeRecordsDao!.findRecordByDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent the save button to move on the top of keyboard when inputing notes
      appBar: AppBar(
        leading: buildBackButton(context: context, size: 24),
        title: buildHeading1Text('${_editMode ? 'Edit' : 'Add'} Entry'),
        actions: [
          // Delete Button
          Visibility(
            visible: _editMode,
            child: IconButton(
                tooltip: 'Help',
                onPressed: () {
                  showConfirmationDialog(
                      context: context,
                      title: 'Delete Entry',
                      message: 'Are you sure you want to delete this entry?',
                      negativeText: 'No',
                      onNegative: () {
                        Navigator.pop(context);
                      },
                      positiveText: 'Yes',
                      onPositive: () {
                        _dailyTimeRecordsModel.dailyTimeRecordsDao!
                            .deleteRecord(_selectedRecord!.id!);
                        _dailyTimeRecordsModel.update();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                },
                icon: SvgPicture.asset(
                  iconDelete,
                  width: 24,
                  height: 24,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
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
              _configureBreakTime(),
              const SizedBox(
                height: 20,
              ),
              _inputNotes()
            ],
          ),
          _saveButton()
        ],
      ),
    );
  }

  bool _validateTimeInputs() {
    final bool isSameDay = _endDate.isAtSameMomentAs(_startDate);

    if (_startTime == _endTime) {
      showSnackBar(context, 'The start and end time should not be the same');
      return true;
    }

    if (_startTime.isAfter(_endTime) && isSameDay) {
      showSnackBar(context, 'The start time should be before the end time');
      return true;
    }

    if (_endTime.isBefore(_startTime) && isSameDay) {
      showSnackBar(context, 'The end time should be after the start time');
      return true;
    }

    if (_breakTimeStart.isAfter(_breakTimeEnd)) {
      showSnackBar(context, 'The start of break time should be before the end of break time');
      return true;
    }

    if (_breakTimeStart.isBefore(_startTime) && isSameDay) {
      showSnackBar(context, 'The start of break time should be after the start time');
      return true;
    }

    if (_breakTimeEnd.isBefore(_breakTimeStart)) {
      showSnackBar(context, 'The end of break time should be after the start of break time');
      return true;
    }

    if (_breakTimeEnd.isAfter(_endTime) && isSameDay) {
      showSnackBar(context, 'The end of break time should be before the end time');
      return true;
    }

    return false;
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
                dateFormat: _dateFormat,
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
                timeFormat: _timeFormat,
                use24HourFormat: _use24HourFormat,
              ),
            ),
          ],
        )
      ],
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
          _endDate = selectedDate.add(const Duration(days: 1));
        });
      },
      onTimePicked: (selectedTime) {
        setState(() {
          _startTime = selectedTime;
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
        if (selectedDate.isBefore(_startDate)) {
          showSnackBar(context, 'The end date should be after the start date');
          return;
        }

        if (selectedDate.difference(_startDate).inDays >= 2) {
          showSnackBar(context, 'The end date can only be the day after the start date');
          return;
        }

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

  Column _configureBreakTime() {
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
      timeFormat: _timeFormat,
      use24HourFormat: _use24HourFormat,
    );
  }

  Column _inputNotes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText('Notes'),
        Container(
          height: 100,
          decoration:
              BoxDecoration(color: palette['inputs'], borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _notes = value;
              });
            },
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
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

  Positioned _saveButton() {
    return Positioned(
        right: 20,
        left: 20,
        bottom: 30,
        child: buildTextButtonLarge('Save ${_editMode ? 'Changes' : ''}', onPressed: () async {
          if (_validateTimeInputs()) return;

          if (_editMode) {
            _dailyTimeRecordsModel.dailyTimeRecordsDao!.updateRecord(DailyTimeRecord(
              id: _selectedRecord?.id,
              dateStart: _startDate.formatToString(),
              dateEnd: _endDate.formatToString(),
              startTime: _startTime.formatToString(),
              endTime: _endTime.formatToString(),
              breakTimeStart: _breakTimeStart.formatToString(),
              breakTimeEnd: _breakTimeEnd.formatToString(),
              notes: _notes,
            ));

            showSnackBar(context, 'Entry updated successfully');
          } else {
            if (_dailyTimeRecordsModel.existingDatesNotifier.value
                .contains(_startDate.formatToString())) {
              showSnackBar(
                  context, 'The selected start of date is already existing in your records');
              return;
            }

            _dailyTimeRecordsModel.dailyTimeRecordsDao!.insertRecord(DailyTimeRecord(
              dateStart: _startDate.formatToString(),
              dateEnd: _endDate.formatToString(),
              startTime: _startTime.formatToString(),
              endTime: _endTime.formatToString(),
              breakTimeStart: _breakTimeStart.formatToString(),
              breakTimeEnd: _breakTimeEnd.formatToString(),
              notes: _notes,
            ));

            showSnackBar(context, 'Entry added successfully');
          }

          _dailyTimeRecordsModel.update();

          Navigator.pop(context);
        }));
  }
}
