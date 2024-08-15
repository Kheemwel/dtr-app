import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';

class Tutorial {
  static final ValueNotifier<bool> showTutorialNotifier = ValueNotifier<bool>(false);
  static final ValueNotifier<int> currentTutorialPageNotifier = ValueNotifier<int>(1);

  static int maxTutorialPage = 4;

  static void init() {
    showTutorialNotifier.value = SharedPref.getShowTutorial();
  }
}
