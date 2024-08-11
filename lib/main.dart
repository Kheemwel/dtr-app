import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/core/utilities/notification_service.dart';
import 'package:flutter_dtr_app/data/models/daily_time_records_model.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/core/utilities/tutorial.dart';
import 'package:flutter_dtr_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  SharedPref.init();

  // Initialize daily time records
  await DailyTimeRecordsModel().update();

  // Initialize local notification service
  await LocalNotificationService().init();

  // Initialize tutorial
  Tutorial.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTR App',
      theme: themeData,
      home: const SplashScreen(),
    );
  }
}
