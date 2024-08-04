import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/datetime_api.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/data/models/daily_time_records_model.dart';
import 'package:flutter_dtr_app/screens/home/add_entry.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
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

  DateTime _currentDate = DateTime.now();
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
        _buildMonthYearDropDown(
            selectedMonthYear: _currentDate,
            minimumYear: _minimumYear,
            maximumYear: _maximumYear,
            onSelected: (DateTime date) {
              setState(() {
                _currentDate = date;
              });
            }),
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

  Widget _buildMonthYearDropDown({
    required DateTime selectedMonthYear,
    required int minimumYear,
    required int maximumYear,
    required Function(DateTime date) onSelected,
  }) {
    final OverlayPortalController tooltipController = OverlayPortalController();
    final link = LayerLink();
    List<int> years = List.generate(maximumYear - minimumYear + 1, (index) => minimumYear + index);
    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: link,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: TabBar(
                              tabAlignment: TabAlignment.center,
                              dividerColor: Colors.transparent,
                              indicatorColor: palette['secondary'],
                              tabs: [
                                buildRegularText('Month', fontSize: 16),
                                buildRegularText('Year', fontSize: 16),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Month Grid View
                                GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.75,
                                  children: List.generate(
                                      _months.length,
                                      (index) => InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: () {
                                              onSelected(
                                                  DateTime(selectedMonthYear.year, index + 1));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: (index + 1) == selectedMonthYear.month
                                                      ? palette['primary']
                                                      : null,
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: buildRegularText(_months[index],
                                                  fontSize: 16,
                                                  color: (index + 1) == selectedMonthYear.month
                                                      ? Colors.white
                                                      : palette['dark']),
                                            ),
                                          )),
                                ),
                                // Year Grid View
                                GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.75,
                                  children: List.generate(
                                      years.length,
                                      (index) => InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: () {
                                              onSelected(
                                                  DateTime(years[index], selectedMonthYear.month));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: years[index] == selectedMonthYear.year
                                                      ? palette['primary']
                                                      : null,
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: buildRegularText(years[index].toString(),
                                                  fontSize: 16,
                                                  color: years[index] == selectedMonthYear.year
                                                      ? Colors.white
                                                      : palette['dark']),
                                            ),
                                          )),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
        },
        child: StatefulBuilder(builder: (_, setState) {
          return InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              setState(() {
                tooltipController.toggle();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildHeading3Text(
                    '${_months[selectedMonthYear.month - 1]} ${selectedMonthYear.year}'),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  tooltipController.isShowing
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 24,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _changeMonth(bool isNext) {
    int newMonth = _currentDate.month + (isNext ? 1 : -1);
    int year = _currentDate.year;
    if (newMonth == 0) {
      if (year == _minimumYear) {
        return;
      }
      _currentDate = DateTime(_currentDate.year - 1, 12, 1);
    } else if (newMonth == 13) {
      if (year == _maximumYear) {
        return;
      }
      _currentDate = DateTime(_currentDate.year + 1, 1, 1);
    } else {
      _currentDate = DateTime(_currentDate.year, newMonth, 1);
    }
    setState(() {});
  }

  Widget _buildCalendarGrid() {
    // Get the day of the first day of a month
    // Ex: July 1, 2024 would result to 1 and then add 1 to make it 2
    // The Sunday will be the first day of the week so it would be 1
    final firstDayOfMonthWeekday = _currentDate.weekday == 7 ? 1 : _currentDate.weekday + 1;

    // Get the total days in a month
    final daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    // Calculate the total number of cells needed (including padding days)
    int totalCells = (firstDayOfMonthWeekday - 1) +
        daysInMonth +
        (7 - ((firstDayOfMonthWeekday + daysInMonth - 1) % 7));

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swiped left
          // Next
          _changeMonth(true);
        } else if (details.primaryVelocity! > 0) {
          // Swiped right
          // Previous
          _changeMonth(false);
        }
      },
      child: GridView.count(
        crossAxisCount: 7,
        mainAxisSpacing: 20,
        children: List.generate(totalCells, (index) {
          int day;

          if (index < firstDayOfMonthWeekday - 1) {
            // Previous month's day
            final previousMonth = DateTime(_currentDate.year, _currentDate.month, 0);
            final previousMonthDays = previousMonth.day;
            day = previousMonthDays - (firstDayOfMonthWeekday - 2 - index);
            return _buildDayCell(DateTime(_currentDate.year, _currentDate.month - 1, day),
                isPreviousMonth: true);
          } else if (index >= firstDayOfMonthWeekday - 1 + daysInMonth) {
            // Next month's day
            day = index - (firstDayOfMonthWeekday - 2 + daysInMonth);
            return _buildDayCell(DateTime(_currentDate.year, _currentDate.month + 1, day),
                isNextMonth: true);
          } else {
            // Current month's day
            day = index - (firstDayOfMonthWeekday - 2);
            return _buildDayCell(DateTime(_currentDate.year, _currentDate.month, day));
          }
        }),
      ),
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
    } else if (isInRecord) {
      textColor = Colors.white;
    } else {
      textColor = palette['dark'];
    }
    return InkWell(
      borderRadius: BorderRadius.circular(180),
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
              color: isInRecord && !(isPreviousMonth || isNextMonth) ? palette['primary'] : null,
            ),
            child: buildRegularText(date.day.toString(), color: textColor, fontSize: 18)),
      ),
    );
  }
}
