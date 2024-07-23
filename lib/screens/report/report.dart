import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/api/datetime_api.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/core/utilities/double_to_time.dart';
import 'package:flutter_dtr_app/core/utilities/notification_service.dart';
import 'package:flutter_dtr_app/core/utilities/string_date_time_formatter.dart';
import 'package:flutter_dtr_app/data/database/daos/daily_time_records_dao.dart';
import 'package:flutter_dtr_app/data/database/entities/daily_time_records.dart';
import 'package:flutter_dtr_app/data/models/daily_time_records_model.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/widgets/data_overview_container.dart';
import 'package:flutter_dtr_app/widgets/date_picker_button.dart';
import 'package:flutter_dtr_app/widgets/show_snackbar.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/svg.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final String _dateFormat = SharedPref.getDateFormat();
  final String _timeFormat = SharedPref.getTimeFormat();

  final DailyTimeRecordsDao? _dailyTimeRecordsDao = DailyTimeRecordsModel().dailyTimeRecordsDao;

  String _totalHours = '0';

  List<DailyTimeRecord> _records = [];

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
          visible: _reportOption == ReportOptions.custom,
          child: _configureCustomDateDuration(),
        ),
        const SizedBox(
          height: 100,
        ),
        buildTextButtonLarge('Generate Report', onPressed: () {
          _exportFile();
        }),
      ],
    );
  }

  void _getRecords() async {
    _records = await _dailyTimeRecordsDao!
        .getRecordsByDateRange(_startDate.formatToString(), _endDate.formatToString());
    double hours = DailyTimeRecord.calculateAllTotalHours(_records);
    _totalHours = hours == 0 ? '0' : convertDoubleToTime(hours);
    setState(() {});
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
      _endDate = DateTime.now();
    });
    _getRecords();
  }

  Excel _createExcel() {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    final headerStyle = CellStyle(bold: true);

    const headerValues = [
      'ID',
      'Start Date',
      'End Date',
      'Start Time',
      'End Time',
      'Break Time Start',
      'Break Time End',
      'Notes',
      'Total Hours',
    ];

    for (int i = 0; i < headerValues.length; i++) {
      final cell = sheet.cell(
          CellIndex.indexByString('${String.fromCharCode(65 + i)}1')); // Use A-based column index
      cell.value = TextCellValue(headerValues[i]);
      cell.cellStyle = headerStyle;
    }

    for (int index = 0; index < _records.length; index++) {
      final cellIndex = index + 2;
      final record = _records[index];

      final values = [
        record.id.toString(),
        formatStringDate(dateString: record.dateStart, toFormat: _dateFormat),
        formatStringDate(dateString: record.dateEnd, toFormat: _dateFormat),
        formatStringTime(timeString: record.startTime, format: _timeFormat),
        formatStringTime(timeString: record.endTime, format: _timeFormat),
        formatStringTime(timeString: record.breakTimeStart, format: _timeFormat),
        formatStringTime(timeString: record.breakTimeEnd, format: _timeFormat),
        record.notes,
        convertDoubleToTime(record.getTotalHours()),
      ];

      for (int i = 0; i < values.length; i++) {
        final cell =
            sheet.cell(CellIndex.indexByString('${String.fromCharCode(65 + i)}$cellIndex'));
        cell.value = TextCellValue(values[i]);
      }
    }

    final totalCellIndex = _records.length + 2;
    Data totalCell = sheet.cell(CellIndex.indexByString('H$totalCellIndex'));
    totalCell.value = const TextCellValue('Total');
    totalCell.cellStyle = headerStyle;
    sheet.cell(CellIndex.indexByString('I$totalCellIndex')).value =
        TextCellValue(convertDoubleToTime(DailyTimeRecord.calculateAllTotalHours(_records)));

    return excel;
  }

  Future<void> _exportFile() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      // If not we will ask for permission first
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    }

    if (status.isGranted) {
      Directory? directory = await getExternalStorageDirectory();

      await directory!.create(recursive: true);
      String path = directory.path;

      String fileName = 'daily_time_records.xlsx';

      // Create the file path
      String filePath = '$path/$fileName';

      var fileBytes = _createExcel().save();

      // Create the file and write the data
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      if (!mounted) return;
      showNotificationAndroid(
          'Report Generation', 'Successfully exported ${_records.length} entries', filePath);
    } else {
      if (!mounted) return;
      showSnackBar(context, 'Failed to Generate Report');
    }
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
                  colorFilter: ColorFilter.mode(palette['icons']!, BlendMode.srcIn),
                ),
                title: _records.length.toString(),
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
                title: _totalHours,
                subtitle: 'Hours')),
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

  RadioListTile _radioOption({required String label, required ReportOptions value}) {
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

                    _getRecords();
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

                    _getRecords();
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
}
