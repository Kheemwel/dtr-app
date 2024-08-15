import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

/// Heading (H1) text
Text buildHeading1Text(String text) {
  return Text(
    text,
    style: textTheme.titleLarge,
  );
}

/// Heading (H2) text
Text buildHeading2Text(String text) {
  return Text(
    text,
    style: textTheme.titleMedium,
  );
}

/// Heading (H3) text
Text buildHeading3Text(String text) {
  return Text(
    text,
    style: textTheme.titleSmall,
  );
}

/// Text for displaying titles or menu labels
Text buildTitleText(String text, {double fontsize = 16, Color? color, bool isCentered = false}) {
  return Text(
    text,
    textAlign: isCentered ? TextAlign.center : null,
    style: textTheme.labelMedium!.copyWith(fontSize: fontsize, color: color ?? palette['dark']),
  );
}

/// Text for displaying text for buttons
Text buildButtonText(String text, {Color? color}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: textTheme.labelLarge!.copyWith(color: color ?? Colors.white),
  );
}

/// Text for displaying regular text
Text buildRegularText(String text, {double fontSize = 12, Color? color, bool isCentered = false}) {
  return Text(
    text,
    textAlign: isCentered ? TextAlign.center : null,
    style: textTheme.bodyMedium!.copyWith(fontSize: fontSize, color: color ?? palette['dark']),
  );
}

/// Text for light labels
Text buildLightText(String text) {
  return Text(
    text,
    style: textTheme.bodySmall,
  );
}
