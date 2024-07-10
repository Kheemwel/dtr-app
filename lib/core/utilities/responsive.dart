import 'package:flutter/material.dart';

/// Get responsive size that can be used to multiply to based font size and image sizes
double getResponsiveSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  const double baseScreenWidth = 360; // Standard screen width
  double scaleFactor = screenWidth / baseScreenWidth;
  return baseSize * scaleFactor;
}
