import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/core/utilities/responsive.dart';
import 'package:flutter_dtr_app/screens/main_screen.dart';
import 'package:flutter_dtr_app/widgets/title_text.dart';

/// The App's Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = getResponsiveSize(context, 24);
    final imageSize = getResponsiveSize(context, 162);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(appLogo, width: imageSize, height: imageSize),
              ),
            ),
            buildTitleText("Daily Time Record", fontSize: fontSize, fontWeight: FontWeight.w900),
          ],
        ),
      ),
    );
  }
}