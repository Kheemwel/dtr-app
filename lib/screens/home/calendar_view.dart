import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/datetime_api.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/data/models/daily_time_records_model.dart';
import 'package:flutter_dtr_app/screens/home/add_entry.dart';
import 'package:flutter_dtr_app/widgets/calendar_popup_menu_item.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _currentDate = DateTime(_selectedYear, DateTime.now().month, 1);
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> _weeks = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  int _selectedYear = DateTime.now().year;
  final int _minimumYear = 2000;
  final int _maximumYear = DateTime.now().year;

  final DailyTimeRecordsModel _dailyTimeRecordsModel = DailyTimeRecordsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: _buildHeader(),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: List.generate(
              7,
              (index) => Expanded(
                    child: Center(child: buildTitleText(_weeks[index], fontsize: 12)),
                  )),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 500,
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _dailyTimeRecordsModel.existingDatesNotifier,
            builder: (context, existingDates, child) {
              return _buildCalendarGrid();
            },
          ),
        ),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PopupMenuButton<String>(
            surfaceTintColor: Colors.white,
            tooltip: 'Select Month',
            constraints: const BoxConstraints(maxHeight: 200),
            position: PopupMenuPosition.under,
            initialValue: _months[_currentDate.month - 1],
            onSelected: (String month) {
              setState(() {
                _currentDate = DateTime(_selectedYear, _months.indexOf(month) + 1, 1);
              });
            },
            itemBuilder: (BuildContext context) => List.generate(
                _months.length,
                (month) => CalendarPopupMenuItem(
                      value: _months[month],
                      isSelected: month == _currentDate.month - 1,
                    )),
            child: buildHeading3Text(_months[_currentDate.month - 1])),
        const SizedBox(
          width: 5,
        ),
        PopupMenuButton<int>(
            tooltip: 'Select Year',
            constraints: const BoxConstraints(maxHeight: 200),
            position: PopupMenuPosition.under,
            initialValue: _selectedYear,
            onSelected: (int year) {
              setState(() {
                _selectedYear = year;
                _currentDate = DateTime(_selectedYear, _currentDate.month, 1);
              });
            },
            itemBuilder: (BuildContext context) => List.generate(
                    _maximumYear - _minimumYear + 1, (index) => _minimumYear + index)
                .map(
                    (year) => CalendarPopupMenuItem(value: year, isSelected: year == _selectedYear))
                .toList(),
            child: buildHeading3Text(_selectedYear.toString())),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeMonth(false),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeMonth(true),
            ),
          ],
        ),
      ],
    );
  }

  void _changeMonth(bool isNext) {
    int newMonth = _currentDate.month + (isNext ? 1 : -1);
    if (newMonth == 0) {
      if (_selectedYear == _minimumYear) {
        return;
      }
      _selectedYear--;
      _currentDate = DateTime(_selectedYear, 12, 1);
    } else if (newMonth == 13) {
      if (_selectedYear == _maximumYear) {
        return;
      }
      _selectedYear++;
      _currentDate = DateTime(_selectedYear, 1, 1);
    } else {
      _currentDate = DateTime(_selectedYear, newMonth, 1);
    }
    setState(() {});
  }

  GridView _buildCalendarGrid() {
    // Get the day of the first day of a month
    // Ex: July 1, 2024 would result to 1 and then add 1 to make it 2
    // The Sunday will be the first day of the week so it would be 1
    final firstDayOfMonthWeekday = _currentDate.weekday == 7 ? 1 : _currentDate.weekday + 1;

    // Get the total days in a month
    final daysInMonth = DateTime(_selectedYear, _currentDate.month + 1, 0).day;

    // Calculate the total number of cells needed (including padding days)
    int totalCells = (firstDayOfMonthWeekday - 1) +
        daysInMonth +
        (7 - ((firstDayOfMonthWeekday + daysInMonth - 1) % 7));

    return GridView.count(
      crossAxisCount: 7,
      mainAxisSpacing: 20,
      children: List.generate(totalCells, (index) {
        int day;

        if (index < firstDayOfMonthWeekday - 1) {
          // Previous month's day
          final previousMonth = DateTime(_selectedYear, _currentDate.month, 0);
          final previousMonthDays = previousMonth.day;
          day = previousMonthDays - (firstDayOfMonthWeekday - 2 - index);
          return _buildDayCell(DateTime(_selectedYear, _currentDate.month - 1, day),
              isPreviousMonth: true);
        } else if (index >= firstDayOfMonthWeekday - 1 + daysInMonth) {
          // Next month's day
          day = index - (firstDayOfMonthWeekday - 2 + daysInMonth);
          return _buildDayCell(DateTime(_selectedYear, _currentDate.month + 1, day),
              isNextMonth: true);
        } else {
          // Current month's day
          day = index - (firstDayOfMonthWeekday - 2);
          return _buildDayCell(DateTime(_selectedYear, _currentDate.month, day));
        }
      }),
    );
  }

  Widget _buildDayCell(DateTime date, {bool isPreviousMonth = false, bool isNextMonth = false}) {
    // Customize the text color based on the month
    final dateToday = DateTime.now();
    final bool isCurrentDate =
        date.isAtSameMomentAs(DateTime(dateToday.year, dateToday.month, dateToday.day));
    final bool isFuture = date.isAfter(DateTime(dateToday.year, dateToday.month, dateToday.day));
    final List<String> existingDates = _dailyTimeRecordsModel.existingDatesNotifier.value;
    final bool isInRecord = existingDates.contains(date.formatToString());

    Color? textColor;
    if (isPreviousMonth || isNextMonth) {
      textColor = palette['faded'];
    } else if (isInRecord && !isCurrentDate) {
      textColor = Colors.white;
    } else {
      textColor = palette['dark'];
    }
    return GestureDetector(
      onTap: () async {
        if (isFuture) {
          return;
        }
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEntry(date: date),
            ));
      },
      child: Center(
        child: Container(
            width: 40,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isCurrentDate ? Border.all(color: palette['secondary']!, width: 3) : null,
              borderRadius: BorderRadius.circular(180),
              color: isInRecord && !isCurrentDate && !(isPreviousMonth || isNextMonth)
                  ? palette['primary']
                  : null,
            ),
            child: buildRegularText(date.day.toString(), color: textColor, fontSize: 18)),
      ),
    );
  }
}
