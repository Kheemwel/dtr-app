// Show dialog for a quick quide
import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

void showGuide(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: buildHeading3Text('Quick Guide')),
              const SizedBox(
                height: 10,
              ),
              buildRegularText(
                  '1. Lunch breaks are excluded from your daily work hours.',
                  fontSize: 16),
              const SizedBox(
                height: 10,
              ),
              buildRegularText(
                  '2. Daily work hours are calculated from the start of your schedule to its end.',
                  fontSize: 16),
              const SizedBox(
                height: 10,
              ),
              buildRegularText(
                  '3. Gray cells indicate blank records. Tap to set the date, time in, and time out.',
                  fontSize: 16),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: buildTextButtonSmall('Close', onPressed: () {
                  Navigator.pop(context);
                }, inverted: true),
              )
            ],
          ),
        ),
      );
    },
  );
}
