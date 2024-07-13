import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

/// Jeading (H1) text
Text buildHeading1Text(String text) {
  return Text(
    text,
    style: textTheme.titleLarge,
  );
}

/// Jeading (H2) text
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
Text buildTitleText(String text, {double fontsize = 16}) {
  return Text(
    text,
    style: textTheme.labelMedium!.copyWith(fontSize: fontsize),
  );
}

/// Text for displaying text for buttons
Text buildButtonText(String text) {
  return Text(
    text,
    style: textTheme.labelLarge,
  );
}

/// Text for displaying regular text
Text buildRegularText(String text, {double fontSize = 12, Color? color}) {
  return Text(
    text,
    style: textTheme.bodyMedium!
        .copyWith(fontSize: fontSize, color: color ?? palette['dark']),
  );
}
