import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  SharedPref.init();

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
