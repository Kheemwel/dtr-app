import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

TextButton buildTextButtonSmall(String text, {required Function onPressed}) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return palette['tertiary']!;
          }

          if (states.contains(WidgetState.hovered)) {
            return palette['tertiary']!;
          }

          return palette['secondary']!;
        }),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
      ),
      onPressed: () {
        onPressed();
      },
      child: buildButtonText(text));
}

TextButton buildTextButtonLarge(String text, {required Function onPressed}) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return palette['tertiary']!;
          }

          if (states.contains(WidgetState.hovered)) {
            return palette['tertiary']!;
          }

          return palette['secondary']!;
        }),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        onPressed();
      },
      child: buildButtonText(text));
}
