// Show dialog for a quick quide
import 'package:flutter/material.dart';

void showGuide(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text('Quick Guide'),
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('1. Lunch breaks are excluded from your daily work hours.'),
              SizedBox(
                height: 10,
              ),
              Text(
                  '2. Daily work hours are calculated from the start of your schedule to its end.'),
              SizedBox(
                height: 10,
              ),
              Text(
                  '3. Gray cells indicate blank records. Tap to set the date, time in, and time out.'),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          )
        ],
      );
    },
  );
}
