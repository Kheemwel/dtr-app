import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/widgets/data_overview_container.dart';
import 'package:flutter_dtr_app/widgets/date_picker_button.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/svg.dart';

enum ReportOptions { lastWeek, thisWeek, thisMonth, thisYear, custom }

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportOptions _reportOption = ReportOptions.custom;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  String _dateFormat = SharedPref.getDateFormat();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        _overviewDatas(),
        const SizedBox(
          height: 30,
        ),
        _radioOptionList(),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            // visible: _reportOption == ReportOptions.custom,
            child: _configureCustomDateDuration()),
        const SizedBox(
          height: 100,
        ),
        buildTextButtonLarge('Generate Report', onPressed: () {})
      ],
    );
  }

  Column _radioOptionList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _radioOption(label: 'Last Week', value: ReportOptions.lastWeek),
        _radioOption(label: 'This Week', value: ReportOptions.thisWeek),
        _radioOption(label: 'This Month', value: ReportOptions.thisMonth),
        _radioOption(label: 'This Year', value: ReportOptions.thisYear),
        _radioOption(label: 'Custom', value: ReportOptions.custom),
      ],
    );
  }

  Padding _configureCustomDateDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLightText('From'),
                buildDatePickerButton(
                  context: context,
                  date: _startDate,
                  onDatePicked: (selectedDate) {
                    setState(() {
                      _startDate = selectedDate;
                    });
                  },
                  dateFormat: _dateFormat,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLightText('To'),
                buildDatePickerButton(
                  context: context,
                  date: _endDate,
                  onDatePicked: (selectedDate) {
                    setState(() {
                      _endDate = selectedDate;
                    });
                  },
                  dateFormat: _dateFormat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changeStartDate(ReportOptions option) {
    DateTime? date;
    switch (option) {
      case ReportOptions.lastWeek:
        date = _endDate.subtract(const Duration(days: 7));
      case ReportOptions.thisWeek:
        date = _endDate.subtract(Duration(days: _endDate.weekday));
      case ReportOptions.thisMonth:
        date = DateTime(_endDate.year, _endDate.month, 1);
      case ReportOptions.thisYear:
        date = DateTime(_endDate.year, 1, 1);
      default:
        date = DateTime.now();
    }
    setState(() {
      _reportOption = option;
      _startDate = date!;
    });
  }

  RadioListTile _radioOption(
      {required String label, required ReportOptions value}) {
    return RadioListTile<ReportOptions>(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: buildRegularText(label, fontSize: 16),
      value: value,
      groupValue: _reportOption,
      onChanged: (ReportOptions? value) {
        _changeStartDate(value!);
      },
    );
  }

  Row _overviewDatas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: buildDataOverviewContainer(
                icon: SvgPicture.asset(
                  iconCalendar,
                  width: 26,
                  height: 26,
                  colorFilter:
                      ColorFilter.mode(palette['icons']!, BlendMode.srcIn),
                ),
                title: '0',
                subtitle: 'Days Worked')),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: buildDataOverviewContainer(
                icon: Icon(
                  Icons.schedule,
                  size: 26,
                  color: palette['icons'],
                ),
                title: '0',
                subtitle: 'Hours')),
      ],
    );
  }
}
