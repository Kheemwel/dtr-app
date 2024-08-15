// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_dtr_app/data/database/daos/daily_time_records_dao.dart';
import 'package:flutter_dtr_app/data/database/entities/daily_time_records.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [DailyTimeRecord])
abstract class AppDatabase extends FloorDatabase {
  DailyTimeRecordsDao get dailyTimeRecordsDao;
}
