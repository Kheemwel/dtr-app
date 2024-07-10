import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

/// Jeading (H1) text
Text buildHeading1Text(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

/// Jeading (H2) text
Text buildHeading2Text(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleMedium,
  );
}

/// Heading (H3) text
Text buildHeading3Text(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleSmall,
  );
}

/// Text for displaying titles or menu labels
Text buildTitleText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.labelMedium,
  );
}

/// Text for displaying text for buttons
Text buildButtonText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.labelLarge,
  );
}

/// Text for displaying regular text
Text buildRegularText(BuildContext context, String text,
    {double fontSize = 12, Color? color}) {
  return Text(
    text,
    style: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontSize: fontSize, color: color ?? palette['dark']),
  );
}
