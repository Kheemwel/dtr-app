import 'package:flutter/material.dart';

final Map<String, Color?> palette = {
  'primary': const Color(0xff192655),
  'secondary': const Color(0xff3876bf),
  'tertiary': const Color(0xffe1aa74),
  'extra': const Color(0xfff3f0ca),
  'danger': const Color(0xffffdbd9),
  'disabled': const Color(0xff8e8e93),
  'dark': const Color(0xff262626),
};

final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  fontFamily: "Roboto", // Default Font
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      color: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
);
