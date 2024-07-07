import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

/// Widget for displaying header or title text
Widget buildTitleText(String text, {double? fontSize, FontWeight? fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: "Nunito",
        color: palette['primary'],
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}
