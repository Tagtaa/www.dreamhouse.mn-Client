import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double dw(double rate) => screenWidth * rate;
  double dh(double rate) => screenHeight * rate;
}

extension DeviceExtension on BuildContext {
  double get heightTypeRate {
    final double width = MediaQuery.of(this).size.width;
    return width > 600 ? 0.33 : 0.25;
  }

  bool get isTablet => MediaQuery.of(this).size.width > 600;
  bool get isSmallScreen => screenHeight < 850;
  bool get isSmallTablet => screenHeight < 1200;
  bool get isLowDensityScreen => MediaQuery.of(this).devicePixelRatio < 3.0;
}
