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

/// Customized the app's default text color
final textTheme = TextTheme(
  displayLarge: TextStyle(
      fontSize: 24,
      fontFamily: 'Nunito',
      color: palette['primary'],
      fontWeight: FontWeight.w900 // Black
      ), // Style for splash screen title
  bodyMedium: TextStyle(
      color: palette['dark'],
      fontFamily: 'Roboto',
      fontSize: 12,
      fontWeight: FontWeight.w400 // Regukar
      ), // Default style for regular text
  titleLarge: TextStyle(
      fontFamily: "Nunito",
      color: palette['primary'],
      fontSize: 24,
      fontWeight: FontWeight.w800 // ExtraBold
      ), // H1
  titleMedium: TextStyle(
      fontFamily: "Nunito",
      color: palette['primary'],
      fontSize: 32,
      fontWeight: FontWeight.w700 // Bold
      ), // H2
  titleSmall: TextStyle(
      fontFamily: "Nunito",
      color: palette['primary'],
      fontSize: 24,
      fontWeight: FontWeight.w700 // Bold
      ), // H3
  labelMedium: TextStyle(
      fontFamily: "Roboto",
      color: palette['dark'],
      fontSize: 16,
      fontWeight: FontWeight.w500 // Medium
      ), // Style for titles, and menu labels
  labelLarge: const TextStyle(
      fontFamily: "Roboto",
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600 // SemiBold
      ), // Style for text in buttons
);

/// Customized Theme Data
final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  fontFamily: "Roboto", // Default Font
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme,
  textTheme: textTheme,
);
