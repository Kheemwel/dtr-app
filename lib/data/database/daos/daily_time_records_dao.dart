import 'package:floor/floor.dart';
import 'package:flutter_dtr_app/data/database/entities/daily_time_records.dart';

@dao
abstract class DailyTimeRecordsDao {
  @Query('SELECT * FROM DailyTimeRecords')
  Future<List<DailyTimeRecord>> getAllRecords();

  @Query('SELECT dateStart FROM DailyTimeRecords')
  Future<List<String>> getAllDates();

  @Query('SELECT * FROM DailyTimeRecords WHERE id = :id')
  Future<DailyTimeRecord?> findRecordById(int id);

  @Query('SELECT * FROM DailyTimeRecords WHERE dateStart = :date')
  Future<DailyTimeRecord?> findRecordByDate(String date);

  @Query('SELECT * FROM DailyTimeRecords WHERE dateStart BETWEEN :fromDate AND :toDate')
  Future<List<DailyTimeRecord>> getRecordsByDateRange(String fromDate, String toDate);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertRecord(DailyTimeRecord record);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateRecord(DailyTimeRecord record);

  @Query('DELETE FROM DailyTimeRecords WHERE id = :id')
  Future<void> deleteRecord(int id);

  @Query('DELETE FROM DailyTimeRecords')
  Future<void> deleteAllRecords();

  @Query('SELECT COUNT(id) FROM DailyTimeRecords')
  Future<int?> getRecordsCount();
}
