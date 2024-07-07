import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/core/utilities/responsive.dart';
import 'package:flutter_dtr_app/screens/home/dtr_grid.dart';
import 'package:flutter_dtr_app/screens/home/user_guide.dart';
import 'package:flutter_dtr_app/screens/report.dart';
import 'package:flutter_dtr_app/screens/settings.dart';
import 'package:flutter_dtr_app/widgets/back_button.dart';
import 'package:flutter_dtr_app/widgets/title_text.dart';
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
      const DTRGrid(),
      const SettingsScreen()
    ];

    final appBars = [
      _reportAppBar(context),
      _homeAppBar(context),
      _settingsAppBar(context),
    ];

    final double navIconSize = getResponsiveSize(context, 24);
    final double navLabelSize = getResponsiveSize(context, 14);
    final navLabelStyle =
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
      leading: buildBackButton(
          context: context, size: getResponsiveSize(context, 24)),
      title:
          buildTitleText('Settings', fontSize: getResponsiveSize(context, 24)),
    );
  }

  AppBar _homeAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.fromLTRB(getResponsiveSize(context, 24), 0, 0, 0),
        child: buildTitleText('Timesheet',
            fontSize: getResponsiveSize(context, 24)),
      ),
      actions: [
        // Help Button
        IconButton(
            tooltip: 'Help',
            onPressed: () => showGuide(context),
            icon: Icon(
              Icons.question_mark_rounded,
              color: palette['primary'],
            ))
      ],
    );
  }

  AppBar _reportAppBar(BuildContext context) {
    return AppBar(
      leading: buildBackButton(
          context: context, size: getResponsiveSize(context, 24)),
      title: buildTitleText('Report', fontSize: getResponsiveSize(context, 24)),
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
