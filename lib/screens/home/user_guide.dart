// Show dialog for a quick quide
import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

const List<String> userGuide = [
  "Daily work hours are calculated from the start of your schedule to its end.",
  "Lunch breaks are excluded from your daily work hours.",
  "Tap either a date or the floating action button to record your time in and out, as well as break time.",
  "Filled date indicates that there is already a record or an entry.",
];

void showGuide(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    iconSize: 24,
                    color: palette['dark'],
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    icon: const Icon(Icons.close_rounded)),
              ),
              Center(child: buildHeading3Text('Quick Guide')),
              ...List.generate(
                  userGuide.length,
                  (index) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: buildRegularText("${index + 1}. ${userGuide[index]}", fontSize: 16),
                      )),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    },
  );
}
