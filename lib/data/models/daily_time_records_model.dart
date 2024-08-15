import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/data/database/daos/daily_time_records_dao.dart';
import 'package:flutter_dtr_app/data/database/database.dart';
import 'package:flutter_dtr_app/data/database/entities/daily_time_records.dart';

class DailyTimeRecordsModel {
  DailyTimeRecordsModel._internal();

  static final DailyTimeRecordsModel _instance = DailyTimeRecordsModel._internal();

  factory DailyTimeRecordsModel() => _instance;

  AppDatabase? database;
  DailyTimeRecordsDao? dailyTimeRecordsDao;

  final ValueNotifier<List<String>> existingDatesNotifier = ValueNotifier<List<String>>([]);
  final ValueNotifier<double> totalHoursNotifier = ValueNotifier<double>(0);

  Future<void> update() async {
    database ??= await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dailyTimeRecordsDao ??= database?.dailyTimeRecordsDao;

    existingDatesNotifier.value = await dailyTimeRecordsDao!.getAllDates();
    final List<DailyTimeRecord> records = await dailyTimeRecordsDao!.getAllRecords();

    totalHoursNotifier.value = DailyTimeRecord.calculateAllTotalHours(records);
  }
}
