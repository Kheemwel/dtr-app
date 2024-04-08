import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/custom_widgets/bordered_container.dart';
import 'package:flutter_dtr_app/custom_widgets/dtr_cell.dart';
import 'package:flutter_dtr_app/database/json_serialization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/dtr_day.dart';

class DTRGrid extends StatefulWidget {
  const DTRGrid({super.key});

  @override
  State<DTRGrid> createState() => _DTRGridState();
}

class _DTRGridState extends State<DTRGrid> {
  late TimeOfDay _lunchStart;
  late TimeOfDay _lunchEnd;
  late TimeOfDay _scheduleStart;
  late TimeOfDay _scheduleEnd;

  late List<List<DTRDay>> _dtrWeeks;

  @override
  void initState() {
    super.initState();
    _lunchStart = const TimeOfDay(hour: 12, minute: 0);
    _lunchEnd = const TimeOfDay(hour: 13, minute: 0);
    _scheduleStart = const TimeOfDay(hour: 8, minute: 0);
    _scheduleEnd = const TimeOfDay(hour: 17, minute: 0);

    _dtrWeeks = [List.generate(7, (index) => DTRDay())];
    _loadData();
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

  void _addNewWeek() {
    setState(() {
      _dtrWeeks.add(List.generate(7, (index) => DTRDay()));
    });
  }

  void _updateDTRDay(int weekIndex, int dayIndex, DateTime date,
      TimeOfDay timeIn, TimeOfDay timeOut) {
    setState(() {
      _dtrWeeks[weekIndex][dayIndex] =
          DTRDay(date: date, timeIn: timeIn, timeOut: timeOut);
    });
  }

  double _calculateTotalWorkHours(int weekIndex) {
  double totalWorkHours = 0;
  for (var day in _dtrWeeks[weekIndex]) {
    final int inMinutes = day.timeIn.hour * 60 + day.timeIn.minute;
    final int outMinutes = day.timeOut.hour * 60 + day.timeOut.minute;

    final int lunchStartMinutes = _lunchStart.hour * 60 + _lunchStart.minute;
    final int lunchEndMinutes = _lunchEnd.hour * 60 + _lunchEnd.minute;

    final int scheduleStartMinutes = _scheduleStart.hour * 60 + _scheduleStart.minute;
    final int scheduleEndMinutes = _scheduleEnd.hour * 60 + _scheduleEnd.minute;

    if (inMinutes < outMinutes) {
      final int effectiveInMinutes = inMinutes < scheduleStartMinutes ? scheduleStartMinutes : inMinutes;
      final int effectiveOutMinutes = outMinutes > scheduleEndMinutes ? scheduleEndMinutes : outMinutes;

      final int workMinutes = effectiveOutMinutes - effectiveInMinutes;
      int lunchMinutes = 0;

      // Check if there is an overlap between work hours and lunch break
      if (effectiveOutMinutes > lunchStartMinutes && effectiveInMinutes < lunchEndMinutes) {
        final int overlapStart = effectiveInMinutes < lunchStartMinutes ? lunchStartMinutes : effectiveInMinutes;
        final int overlapEnd = effectiveOutMinutes > lunchEndMinutes ? lunchEndMinutes : effectiveOutMinutes;
        lunchMinutes = overlapEnd - overlapStart;
      }

      totalWorkHours += (workMinutes - lunchMinutes) / 60.0;
    }
  }
  return totalWorkHours;
}


  double _calculateTotalWorkHoursAllWeeks() {
    double totalWorkHours = 0;
    for (var week in _dtrWeeks) {
      totalWorkHours += _calculateTotalWorkHours(_dtrWeeks.indexOf(week));
    }
    return totalWorkHours;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _saveData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString('dtr');

    if (json != null && json != '') {
      final DTR dtr = DTR.fromJson(JSON.toMap(json));
      setState(() {
        _lunchStart = dtr.lunchStart;
        _lunchEnd = dtr.lunchEnd;
        _scheduleStart = dtr.scheduleStart;
        _scheduleEnd = dtr.scheduleEnd;
        _dtrWeeks = dtr.dtrWeeks;
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    final DTR dtr = DTR(
        lunchStart: _lunchStart,
        lunchEnd: _lunchEnd,
        scheduleStart: _scheduleStart,
        scheduleEnd: _scheduleEnd,
        dtrWeeks: _dtrWeeks);

    String json = JSON.stringify(dtr.toJson());

    prefs.setString('dtr', json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Time Record'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(10), child: Wrap(
            spacing: 25,
            runSpacing: 25,
            children: [
              Column(
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
                ],
              ),
              Column(
                children: [
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
                ],
              ),
              Column(
                children: [
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
                ],
              ),
              Column(
                children: [
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
                ],
              ),
            ],
          ),),
          const SizedBox(height: 25),
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 75,
                        child: Row(
                          children: [
                            BorderedContainer(
                              width: 200,
                              child: Text('Week No.'),
                            ),
                            DTRCell(
                              dateText: 'Monday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Tuesday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Wednesday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Thursday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Monday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Saturday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            DTRCell(
                              dateText: 'Sunday',
                              timeInText: 'Time In',
                              timeOutText: 'Time Out',
                            ),
                            BorderedContainer(
                              width: 200,
                              child: Text('Total No. of Hours Per Week'),
                            ),
                          ],
                        ),
                      ),
                      ...List.generate(
                        _dtrWeeks.length,
                        (weekIndex) => SizedBox(
                          height: 75,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const BorderedContainer(
                                      height: 30,
                                      width: 200,
                                      child: Text('Date')),
                                  BorderedContainer(
                                      height: 45,
                                      width: 200,
                                      child: Text('${weekIndex + 1}'))
                                ],
                              ),
                              ...List.generate(
                                7,
                                (dayIndex) {
                                  final day = _dtrWeeks[weekIndex][dayIndex];
                                  return GestureDetector(
                                      onTap: () async {
                                        final DateTime? date =
                                            await showDatePicker(
                                          helpText: 'Select Date',
                                          context: context,
                                          initialDate: day.date,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (date != null) {
                                          final TimeOfDay? timeIn =
                                              await showTimePicker(
                                            helpText: 'Select Time In',
                                            context: context,
                                            initialTime: day.timeIn,
                                          );

                                          if (timeIn != null) {
                                            final TimeOfDay? timeOut =
                                                await showTimePicker(
                                              helpText: 'Select Time Out',
                                              context: context,
                                              initialTime: day.timeOut,
                                            );
                                            if (timeOut != null) {
                                              _updateDTRDay(weekIndex, dayIndex,
                                                  date, timeIn, timeOut);
                                            }
                                          }
                                        }
                                      },
                                      child: DTRCell(
                                        dateText: day.date != null
                                            ? day.getFormattedDate()
                                            : '',
                                        timeInText: day.timeIn.hour > 0
                                            ? day.timeIn.format(context)
                                            : '',
                                        timeOutText: day.timeOut.hour > 0
                                            ? day.timeOut.format(context)
                                            : '',
                                      ));
                                },
                              ),
                              BorderedContainer(
                                  width: 200,
                                  child: Text(
                                      _calculateTotalWorkHours(weekIndex)
                                          .toStringAsFixed(2)))
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const SizedBox(
                            width: 200,
                            height: 75,
                          ),
                          const BorderedContainer(
                              height: 75, width: 200, child: Text('Total')),
                          BorderedContainer(
                              height: 75,
                              width: 200,
                              child: Text(_calculateTotalWorkHoursAllWeeks()
                                  .toStringAsFixed(2))),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _addNewWeek,
        child: const Text('Add New Week'),
      ),
    );
  }
}
