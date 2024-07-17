import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

/// Small text buttons primary used for dialogs
TextButton buildTextButtonSmall(String text,
    {required Function onPressed, bool inverted = false}) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return inverted
                ? palette['tertiary-variant']!
                : palette['tertiary']!;
          }

          if (states.contains(WidgetState.hovered)) {
            return inverted
                ? palette['tertiary-variant']!
                : palette['tertiary']!;
          }

          return inverted ? Colors.white : palette['secondary']!;
        }),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        onPressed();
      },
      child: buildButtonText(text, color: inverted ? palette['dark'] : null));
}

/// Large text buttons primary used for forms
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
            EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        onPressed();
      },
      child: buildButtonText(text));
}
