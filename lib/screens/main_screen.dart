import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/screens/home/user_guide.dart';
import 'package:flutter_dtr_app/screens/report.dart';
import 'package:flutter_dtr_app/screens/settings/settings.dart';
import 'package:flutter_dtr_app/screens/home/home_screen.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The app's main screen where the bottom navigation bar is displayed
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      _reportAppBar(context),
      _homeAppBar(context),
      _settingsAppBar(context),
    ];

    const double navIconSize = 24;
    const double navLabelSize = 14;
    const navLabelStyle =
        TextStyle(fontWeight: FontWeight.w500, fontSize: navLabelSize);

    return Scaffold(
      appBar: appBars.elementAt(_selectedIndex),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _bottomNavigationBar(navIconSize, navLabelStyle),
    );
  }

  AppBar _settingsAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Settings'),
      ),
    );
  }

  AppBar _homeAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Timesheet'),
      ),
      actions: [
        // Help Button
        IconButton(
            tooltip: 'Help',
            onPressed: () => showGuide(context),
            icon: Icon(
              Icons.question_mark_rounded,
              color: palette['primary'],
            )),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  AppBar _reportAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: buildHeading1Text('Report'),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(
      double navIconSize, TextStyle navLabelStyle) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _navReport(navIconSize),
        _navHome(navIconSize),
        _navSettings(navIconSize),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: palette['disabled'],
      selectedItemColor: palette['secondary'],
      selectedLabelStyle: navLabelStyle,
      unselectedLabelStyle: navLabelStyle,
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _navSettings(double navIconSize) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_rounded,
        size: navIconSize,
      ),
      label: 'Settings',
    );
  }

  BottomNavigationBarItem _navHome(double navIconSize) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconHome,
        width: navIconSize,
        height: navIconSize,
        colorFilter: ColorFilter.mode(
            _selectedIndex == 1 ? palette['secondary']! : palette['disabled']!,
            BlendMode.srcIn),
      ),
      label: 'Home',
    );
  }

  BottomNavigationBarItem _navReport(double navIconSize) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.view_list_rounded,
        size: navIconSize,
      ),
      label: 'Report',
    );
  }
}
