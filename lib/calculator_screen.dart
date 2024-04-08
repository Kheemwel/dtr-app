import 'package:flutter/material.dart';

class WorkHoursCalculator extends StatefulWidget {
  const WorkHoursCalculator({super.key});

  @override
  State<WorkHoursCalculator> createState() => _WorkHoursCalculatorState();
}

class _WorkHoursCalculatorState extends State<WorkHoursCalculator> {
  late TimeOfDay _lunchStart;
  late TimeOfDay _lunchEnd;
  late TimeOfDay _scheduleStart;
  late TimeOfDay _scheduleEnd;
  late DateTime _date;
  late TimeOfDay _timeIn;
  late TimeOfDay _timeOut;
  late String _totalHours;

  @override
  void initState() {
    super.initState();
    _lunchStart = const TimeOfDay(hour: 12, minute: 0);
    _lunchEnd = const TimeOfDay(hour: 13, minute: 0);
    _scheduleStart = const TimeOfDay(hour: 8, minute: 0);
    _scheduleEnd = const TimeOfDay(hour: 17, minute: 0);
    _date = DateTime.now();
    _timeIn = const TimeOfDay(hour: 8, minute: 0);
    _timeOut = const TimeOfDay(hour: 17, minute: 0);
    _calculateTotalWorkHours();
  }

  void _updateDate(DateTime newDate) {
    setState(() {
      _date = newDate;
    });
  }

  void _updateTimeIn(TimeOfDay newTime) {
    setState(() {
      _timeIn = newTime;
    });
    _calculateTotalWorkHours();
  }

  void _updateTimeOut(TimeOfDay newTime) {
    setState(() {
      _timeOut = newTime;
    });
    _calculateTotalWorkHours();
  }

  void _calculateTotalWorkHours() {
    if (_timeIn.hour < _scheduleStart.hour) {
      _timeIn = _scheduleStart;
    }
    if (_timeOut.hour > _scheduleEnd.hour) {
      _timeOut = _scheduleEnd;
    }

    final DateTime inDateTime = DateTime(
        _date.year, _date.month, _date.day, _timeIn.hour, _timeIn.minute);
    final DateTime outDateTime = DateTime(
        _date.year, _date.month, _date.day, _timeOut.hour, _timeOut.minute);
    final DateTime lunchStartDateTime = DateTime(_date.year, _date.month,
        _date.day, _lunchStart.hour, _lunchStart.minute);
    final DateTime lunchEndDateTime = DateTime(
        _date.year, _date.month, _date.day, _lunchEnd.hour, _lunchEnd.minute);
    final DateTime scheduleStartDateTime = DateTime(_date.year, _date.month,
        _date.day, _scheduleStart.hour, _scheduleStart.minute);
    final DateTime scheduleEndDateTime = DateTime(_date.year, _date.month,
        _date.day, _scheduleEnd.hour, _scheduleEnd.minute);

    double totalWorkHours = 0;

    if (inDateTime.isBefore(outDateTime)) {
      if (inDateTime.isBefore(scheduleStartDateTime)) {
        inDateTime.add(Duration(
            hours: scheduleStartDateTime.hour - inDateTime.hour,
            minutes: scheduleStartDateTime.minute - inDateTime.minute));
      }
      if (outDateTime.isAfter(scheduleEndDateTime)) {
        outDateTime.add(Duration(
            hours: scheduleEndDateTime.hour - outDateTime.hour,
            minutes: scheduleEndDateTime.minute - outDateTime.minute));
      }

      final lunchDuration = lunchEndDateTime.difference(lunchStartDateTime);
      totalWorkHours = outDateTime.difference(inDateTime).inMinutes / 60.0;
      totalWorkHours -= lunchDuration.inMinutes / 60.0;
    }

    setState(() {
      _totalHours = totalWorkHours.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Hours Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${_date.toString().substring(0, 10)}'),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  _updateDate(pickedDate);
                }
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 16),
            Text('Time In: ${_timeIn.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _timeIn,
                );
                if (pickedTime != null) {
                  _updateTimeIn(pickedTime);
                }
              },
              child: const Text('Select Time In'),
            ),
            const SizedBox(height: 16),
            Text('Time Out: ${_timeOut.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _timeOut,
                );
                if (pickedTime != null) {
                  _updateTimeOut(pickedTime);
                }
              },
              child: const Text('Select Time Out'),
            ),
            const SizedBox(height: 16),
            Text('Total Work Hours: $_totalHours hours'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Total Work Hours'),
                    content: Text(
                        'Total Work Hours: $_totalHours hours'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Calculate Total Work Hours'),
            ),
          ],
        ),
      ),
    );
  }
}
