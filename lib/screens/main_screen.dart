import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/data/shared_preferences/sharedpref.dart';
import 'package:flutter_dtr_app/screens/home/user_guide.dart';
import 'package:flutter_dtr_app/screens/report/report.dart';
import 'package:flutter_dtr_app/screens/settings/settings.dart';
import 'package:flutter_dtr_app/screens/home/home_screen.dart';
import 'package:flutter_dtr_app/core/utilities/tutorial.dart';
import 'package:flutter_dtr_app/widgets/text_button.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';

/// The app's main screen where the bottom navigation bar is displayed
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  bool _startTutorial = false;

  @override
  void initState() {
    super.initState();

    if (Tutorial.showTutorialNotifier.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTutorialDialog();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showTutorialDialog() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shadowColor: palette['dark'],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          width: 300,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                    iconSize: 24,
                    color: palette['dark'],
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    icon: const Icon(Icons.close_rounded)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        partyCone,
                        width: 52,
                        height: 52,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: buildHeading3Text('Welcome To DTR')),
                    Center(
                      child: buildRegularText(
                          "We’ll guide you through a quick tour to get started.",
                          isCentered: true),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextButtonSmall("Let's Start", onPressed: () {
                      Navigator.pop(context, true);
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (result != null) {
      if (result) {
        Tutorial.showTutorialNotifier.value = true;
        _startTutorial = true;
      } else {
        Tutorial.showTutorialNotifier.value = false;
        SharedPref.setShowTutorial(false);
      }
      setState(() {});
    }
  }

  void _showGetStartDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shadowColor: palette['dark'],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 300,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  clappingHands,
                  width: 52,
                  height: 52,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(child: buildHeading3Text("You're All Set")),
              Center(
                child: buildRegularText(
                    "You now know the basics of using DTR. Start tracking your time effortlessly.",
                    isCentered: true),
              ),
              const SizedBox(
                height: 20,
              ),
              buildTextButtonSmall("Get Started", onPressed: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  void _nextTutorial() {
    Tutorial.currentTutorialPageNotifier.value++;

    if (Tutorial.currentTutorialPageNotifier.value > Tutorial.maxTutorialPage) {
      Tutorial.showTutorialNotifier.value = false;
      Tutorial.currentTutorialPageNotifier.value = 1;
      _startTutorial = false;
      SharedPref.setShowTutorial(false);
      _showGetStartDialog();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const ReportScreen(),
      // const DTRGrid(),
      const HomeScreen(),
      const SettingsScreen()
    ];

    final appBars = [
      _reportAppBar(),
      _homeAppBar(),
      _settingsAppBar(),
    ];

    return GestureDetector(
      onTap: () {
        if (Tutorial.showTutorialNotifier.value) {
          _nextTutorial();
        }
      },
      child: OverlayTutorialScope(
        overlayColor: Colors.black54,
        enabled: _startTutorial && Tutorial.showTutorialNotifier.value,
        child: AbsorbPointer(
          absorbing: _startTutorial && Tutorial.showTutorialNotifier.value,
          child: Scaffold(
            appBar: appBars.elementAt(_selectedIndex),
            body: Center(
              child: screens.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: _bottomNavBar(_selectedIndex),
          ),
        ),
      ),
    );
  }

  AppBar _settingsAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Settings'),
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Timesheet'),
      ),
      actions: [
        // Help Button
        CircleAvatar(
          backgroundColor: palette['overview'],
          child: IconButton(
              tooltip: 'Help',
              onPressed: () => showGuide(context),
              icon: Icon(
                Icons.question_mark_rounded,
                color: palette['primary'],
              )),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  AppBar _reportAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Report'),
      ),
    );
  }

  Widget _bottomNavBar(int selectedIndex) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(0, 2), // Top
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _navReport(selectedIndex),
          _navHome(selectedIndex),
          _navSettings(selectedIndex),
        ],
      ),
    );
  }

  Widget _navSettings(int selectedIndex) {
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(2),
        child: OverlayTutorialHole(
          enabled: Tutorial.showTutorialNotifier.value &&
              Tutorial.currentTutorialPageNotifier.value == 4,
          overlayTutorialEntry: OverlayTutorialRectEntry(overlayTutorialHints: [
            OverlayTutorialWidgetHint(
              builder: (context, entryRect) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 200,
                          child: buildTitleText(
                              'Tap to select date and time formats, set daily and break schedules, or clear all entries.',
                              fontsize: 20,
                              color: Colors.white,
                              isCentered: true),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          iconGuideArrowDown,
                          width: 48,
                          height: 48,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings_rounded,
                size: 24,
                color: selectedIndex == 2 ? palette['secondary'] : palette['disabled'],
              ),
              buildTitleText('Settings',
                  fontsize: 14,
                  color: selectedIndex == 2 ? palette['secondary'] : palette['disabled']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navHome(int selectedIndex) {
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconHome,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? palette['secondary']! : palette['disabled']!,
                  BlendMode.srcIn),
            ),
            buildTitleText('Home',
                fontsize: 14,
                color: selectedIndex == 1 ? palette['secondary'] : palette['disabled']),
          ],
        ),
      ),
    );
  }

  Widget _navReport(int selectedIndex) {
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(0),
        child: OverlayTutorialHole(
          enabled: Tutorial.showTutorialNotifier.value &&
              Tutorial.currentTutorialPageNotifier.value == 3,
          overlayTutorialEntry: OverlayTutorialRectEntry(overlayTutorialHints: [
            OverlayTutorialWidgetHint(
              builder: (context, entryRect) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 200,
                          child: buildTitleText(
                              'Tap to convert your entries into a table format based on your preferred date range.',
                              fontsize: 20,
                              color: Colors.white,
                              isCentered: true),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          iconGuideArrowDown,
                          width: 48,
                          height: 48,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.view_list_rounded,
                size: 24,
                color: selectedIndex == 0 ? palette['secondary'] : palette['disabled'],
              ),
              buildTitleText('Report',
                  fontsize: 14,
                  color: selectedIndex == 0 ? palette['secondary'] : palette['disabled']),
            ],
          ),
        ),
      ),
    );
  }
}
