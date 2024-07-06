import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/constants.dart';
import 'package:flutter_dtr_app/screens/dtr_grid.dart';
import 'package:flutter_dtr_app/widgets/title_text.dart';

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
          MaterialPageRoute(builder: (context) => const DTRGrid()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseFontSize = 24;
    const baseImageSize = 162;
    final fontSize = baseFontSize * (screenWidth / 360);
    final imageSize = baseImageSize * (screenWidth / 360);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
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

@override
Widget build(BuildContext context) {
  return const Placeholder();
}