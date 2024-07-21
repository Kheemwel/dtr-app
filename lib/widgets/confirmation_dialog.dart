import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String negativeText,
  required Function onNegative,
  required String positiveText,
  required Function onPositive,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildHeading3Text(title),
            const SizedBox(
              height: 10,
            ),
            buildRegularText(message, fontSize: 16, isCentered: true),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: buildTextButtonSmall(negativeText, onPressed: onNegative, inverted: true),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: buildTextButtonSmall(positiveText, onPressed: onPositive),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
