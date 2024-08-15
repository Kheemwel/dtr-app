import 'package:flutter/material.dart';

/// The app's palette
final Map<String, Color> palette = {
  'primary': const Color(0xff192655),
  'secondary': const Color(0xff3876bf),
  'tertiary': const Color(0xff2f64a1),
  'tertiaryVariant': const Color(0xffeaf4ff),
  'icons': const Color(0xffe1aa74),
  'overview': const Color(0xfffffeec),
  'inputs': const Color(0xfff2f2f7),
  'danger': const Color(0xffffdbd9),
  'disabled': const Color(0xff8e8e93),
  'dark': const Color(0xff262626),
  'faded': const Color(0xffe5e5ea),
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
  bodySmall: TextStyle(
      color: palette['dark'],
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w300 // Light
      ), // Style for light labels
  bodyMedium: TextStyle(
      color: palette['dark'],
      fontFamily: 'Roboto',
      fontSize: 12,
      fontWeight: FontWeight.w400 // Regular
      ), // Default style for regular text
  titleLarge: TextStyle(
      fontFamily: "Nunito",
      color: palette['primary'],
      fontSize: 24,
      fontWeight: FontWeight.w800 // ExtraBold
      ), // H1
  titleMedium: TextStyle(
      height: 1,
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

/// Customized style of Floating Action Button
final floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: palette['secondary'],
  splashColor: palette['tertiary'],
  hoverColor: palette['tertiary'],
  shape: const CircleBorder(),
);

/// Customized theme for Radio Buttons
final radioTheme = RadioThemeData(
  fillColor: WidgetStatePropertyAll(palette['primary']),
);

/// Customized theme for Date Picker
final datePickerTheme = DatePickerThemeData(
  dividerColor: Colors.transparent,
  backgroundColor: Colors.white,
  dayOverlayColor: WidgetStatePropertyAll(palette['secondary']),
  yearOverlayColor: WidgetStatePropertyAll(palette['secondary']),
  dayForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.white;
    }

    if (states.contains(WidgetState.disabled)) {
      return palette['disabled']!;
    }

    return palette['dark']!;
  }),
  dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return palette['primary']!;
    }
    return Colors.transparent;
  }),
  yearForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.white;
    }

    if (states.contains(WidgetState.disabled)) {
      return palette['disabled']!;
    }

    return palette['dark']!;
  }),
  yearBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return palette['primary']!;
    }
    return Colors.transparent;
  }),
  todayForegroundColor: const WidgetStatePropertyAll(Colors.white),
  todayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return palette['primary']!;
    }
    return palette['secondary']!;
  }),
  headerForegroundColor: palette['dark'],
);

/// Customized theme for menus
final menuTheme = MenuThemeData(
    style: MenuStyle(
  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
));

/// Cutomized theme for popup menus
final popupMenuTheme = PopupMenuThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);

/// Customized theme for SnackBar
final snackBarTheme = SnackBarThemeData(
  backgroundColor: palette['dark'],
  contentTextStyle: textTheme.bodyMedium!.copyWith(fontSize: 12, color: Colors.white),
);

/// Customized Theme Data
final themeData = ThemeData(
  colorScheme: ColorScheme.light(
    primary: palette['primary']!,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: palette['dark']!,
  ),
  fontFamily: "Roboto", // Default Font
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme,
  textTheme: textTheme,
  floatingActionButtonTheme: floatingActionButtonTheme,
  radioTheme: radioTheme,
  dialogBackgroundColor: Colors.white,
  datePickerTheme: datePickerTheme,
  menuTheme: menuTheme,
  popupMenuTheme: popupMenuTheme,
  snackBarTheme: snackBarTheme,
);
