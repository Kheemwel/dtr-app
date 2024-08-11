import 'package:flutter_dtr_app/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Collection of functions for handling SharedPreferences
class SharedPref {
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save date format to SharedPreferences
  static void setDateFormat(String format) {
    _prefs.setString('dateFormat', format);
  }

  /// Retrieve date format from SharedPreferences
  static String getDateFormat() {
    var formats = dateFormats.keys;
    return _prefs.getString('dateFormat') ?? formats.first;
  }

  /// Save time format to SharedPreferences
  static void setTimeFormat(String format) {
    _prefs.setString('timeFormat', format);
  }

  /// Retrieve date format from SharedPreferences
  static String getTimeFormat() {
    var formats = timeFormats.keys;
    return _prefs.getString('timeFormat') ?? formats.first;
  }

  /// Save daily schedule start to SharedPreferences
  static void setDailyScheduleStart(String time) {
    _prefs.setString('dailyScheduleStart', time);
  }

  /// Retrieve daily schedule start from SharedPreferences
  static String getDailyScheduleStart() {
    return _prefs.getString('dailyScheduleStart') ?? '8:00';
  }

  /// Save daily schedule end to SharedPreferences
  static void setDailyScheduleEnd(String time) {
    _prefs.setString('dailyScheduleEnd', time);
  }

  /// Retrieve daily schedule end from SharedPreferences
  static String getDailyScheduleEnd() {
    return _prefs.getString('dailyScheduleEnd') ?? '17:00';
  }

  /// Save break time start to SharedPreferences
  static void setBreakTimeStart(String time) {
    _prefs.setString('breakTimeStart', time);
  }

  /// Retrieve break time start from SharedPreferences
  static String getBreakTimeStart() {
    return _prefs.getString('breakTimeStart') ?? '12:00';
  }

  /// Save break time end to SharedPreferences
  static void setBreakTimeEnd(String time) {
    _prefs.setString('breakTimeEnd', time);
  }

  /// Retrieve break time end from SharedPreferences
  static String getBreakTimeEnd() {
    return _prefs.getString('breakTimeEnd') ?? '13:00';
  }

  /// Clear all data from SharedPreferences
  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  static void setShowTutorial(bool show) {
    _prefs.setBool('showTutorial', show);
  }

  static bool getShowTutorial() {
    return _prefs.getBool('showTutorial') ?? true;
  }
}
