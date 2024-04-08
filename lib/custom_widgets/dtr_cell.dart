import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/custom_widgets/bordered_container.dart';

class DTRCell extends StatelessWidget {
  const DTRCell(
      {super.key,
      this.dateText = '',
      this.timeInText = '',
      this.timeOutText = ''});
  final String dateText;
  final String timeInText;
  final String timeOutText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BorderedContainer(
            height: 30,
            color: dateText != '' ? Colors.white : Colors.grey,
            child: Text(dateText),
          ),
          SizedBox(
              height: 45,
              child: Row(
                children: [
                  BorderedContainer(
                      width: 100,
                      color: timeInText != '' ? Colors.white : Colors.grey,
                      child: Text(timeInText)),
                  BorderedContainer(
                      width: 100,
                      color: timeOutText != '' ? Colors.white : Colors.grey,
                      child: Text(timeOutText))
                ],
              ))
        ],
      ),
    );
  }
}
