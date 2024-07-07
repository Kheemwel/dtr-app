import 'package:flutter/material.dart';

/// The app's palette
final Map<String, Color> palette = {
  'primary': const Color(0xff192655),
  'secondary': const Color(0xff3876bf),
  'tertiary': const Color(0xff2f64a1),
  'icons': const Color(0xffe1aa74),
  'overview': const Color(0xfff3f0ca),
  'inputs': const Color(0xfff2f2f7),
  'danger': const Color(0xffffdbd9),
  'disabled': const Color(0xff8e8e93),
  'dark': const Color(0xff262626),
};

/// Customized App Bar Theme
final appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: palette['primary'], size: 24),
    titleSpacing: 0,
    titleTextStyle: TextStyle(
        color: palette['primary'],
        fontFamily: 'Nunito',
        fontSize: 24,
        fontWeight: FontWeight.w800));

/// Customized Theme Data
final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  fontFamily: "Roboto", // Default Font
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme,
);
