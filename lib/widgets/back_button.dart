import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Customized back button for Scaffold leading icon
Widget buildBackButton({required BuildContext context, double? size}) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: SvgPicture.asset(
        iconBack,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(palette['dark']!, BlendMode.srcIn),
      ));
}
