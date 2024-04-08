import 'package:flutter/material.dart';


class DTRScreen extends StatefulWidget {
  const DTRScreen({super.key});

  @override
  State<DTRScreen> createState() => _DTRScreenState();
}

class _DTRScreenState extends State<DTRScreen> {
  late TimeOfDay _lunchStart;
  late TimeOfDay _lunchEnd;
  late TimeOfDay _scheduleStart;
  late TimeOfDay _scheduleEnd;

  late List<DTRDay> _dtrDays;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _lunchStart = const TimeOfDay(hour: 12, minute: 0);
    _lunchEnd = const TimeOfDay(hour: 13, minute: 0);
    _scheduleStart = const TimeOfDay(hour: 8, minute: 0);
    _scheduleEnd = const TimeOfDay(hour: 17, minute: 0);

    _dtrDays = List.generate(7, (index) => DTRDay());
    _selectedDate = DateTime.now();
  }

  void _updateLunchStart(TimeOfDay newTime) {
    setState(() {
      _lunchStart = newTime;
    });
  }

  void _updateLunchEnd(TimeOfDay newTime) {
    setState(() {
      _lunchEnd = newTime;
    });
  }

  void _updateScheduleStart(TimeOfDay newTime) {
    setState(() {
      _scheduleStart = newTime;
    });
  }

  void _updateScheduleEnd(TimeOfDay newTime) {
    setState(() {
      _scheduleEnd = newTime;
    });
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  void _updateDTRDay(int index, TimeOfDay timeIn, TimeOfDay timeOut) {
    setState(() {
      _dtrDays[index] = DTRDay(timeIn: timeIn, timeOut: timeOut);
    });
  }

  double _calculateTotalWorkHours() {
    double totalWorkHours = 0;
    for (var day in _dtrDays) {
      final DateTime inDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, day.timeIn.hour, day.timeIn.minute);
      final DateTime outDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, day.timeOut.hour, day.timeOut.minute);
      final DateTime lunchStartDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, _lunchStart.hour, _lunchStart.minute);
      final DateTime lunchEndDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, _lunchEnd.hour, _lunchEnd.minute);
      final DateTime scheduleStartDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, _scheduleStart.hour, _scheduleStart.minute);
      final DateTime scheduleEndDateTime = DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day, _scheduleEnd.hour, _scheduleEnd.minute);

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
        totalWorkHours += outDateTime.difference(inDateTime).inMinutes / 60.0;
        totalWorkHours -= lunchDuration.inMinutes / 60.0;
      }
    }
    return totalWorkHours;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DTR System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lunch Start: ${_lunchStart.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _lunchStart,
                );
                if (pickedTime != null) {
                  _updateLunchStart(pickedTime);
                }
              },
              child: const Text('Select Lunch Start'),
            ),
            const SizedBox(height: 16),
            Text('Lunch End: ${_lunchEnd.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _lunchEnd,
                );
                if (pickedTime != null) {
                  _updateLunchEnd(pickedTime);
                }
              },
              child: const Text('Select Lunch End'),
            ),
            const SizedBox(height: 16),
            Text('Schedule Start: ${_scheduleStart.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _scheduleStart,
                );
                if (pickedTime != null) {
                  _updateScheduleStart(pickedTime);
                }
              },
              child: const Text('Select Schedule Start'),
            ),
            const SizedBox(height: 16),
            Text('Schedule End: ${_scheduleEnd.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _scheduleEnd,
                );
                if (pickedTime != null) {
                  _updateScheduleEnd(pickedTime);
                }
              },
              child: const Text('Select Schedule End'),
            ),
            const SizedBox(height: 16),
            Text('Date: ${_selectedDate.toString().substring(0, 10)}'),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  _updateSelectedDate(pickedDate);
                }
              },
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 16),
            const Text('DTR Entries:'),
            Expanded(
              child: ListView.builder(
                itemCount: _dtrDays.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Day ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time In: ${_dtrDays[index].timeIn.format(context)}'),
                        Text('Time Out: ${_dtrDays[index].timeOut.format(context)}'),
                      ],
                    ),
                    onTap: () async {
                      final TimeOfDay? timeIn = await showTimePicker(
                        context: context,
                        initialTime: _dtrDays[index].timeIn,
                      );
                      if (timeIn != null) {
                        final TimeOfDay? timeOut = await showTimePicker(
                          context: context,
                          initialTime: _dtrDays[index].timeOut,
                        );
                        if (timeOut != null) {
                          _updateDTRDay(index, timeIn, timeOut);
                        }
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final totalWorkHours = _calculateTotalWorkHours();
                final formattedTotalWorkHours =
                    totalWorkHours.toStringAsFixed(2);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Total Work Hours'),
                    content: Text(
                        'Total Work Hours: $formattedTotalWorkHours hours'),
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

class DTRDay {
  TimeOfDay timeIn;
  TimeOfDay timeOut;

  DTRDay({this.timeIn = const TimeOfDay(hour: 8, minute: 0), this.timeOut = const TimeOfDay(hour: 17, minute: 0)});
}
