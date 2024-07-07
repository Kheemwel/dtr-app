import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';

/// Customized back button for Scaffold leading icon
Widget buildBackButton({required BuildContext context, double? size}) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.keyboard_arrow_left_rounded,
        size: size,
        color: palette['primary'],
      ));
}
