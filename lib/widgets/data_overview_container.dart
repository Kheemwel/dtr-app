import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

Container buildDataOverviewContainer(
    {required Widget icon, required String title, required String subtitle}) {
  return Container(
    decoration: BoxDecoration(
      color: palette['overview'],
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 32,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buildHeading2Text(title),
              ),
            ),
            buildRegularText(subtitle),
          ],
        )
      ],
    ),
  );
}
