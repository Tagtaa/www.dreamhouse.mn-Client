import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

abstract final class AppSize {
  static const double paddingZero = 0;
  static const double paddingLowest = 5;
  static const double paddingLow = 10;
  static const double padding = 15;
  static const double paddingNormal = 20;
  static const double paddingHigh = 30;
  static const double paddingHighest = 50;

  static const double icon = 24;

  static const double navigationBarHeight = 56;
  static const double navigationBarIconSize = 24;

  static const double floatingActionButtonSize = 56;

  static const double appBarHeight = 56;
  static const double appBarElevation = 1;

  static const double dividerThickness = 0.33;

  static const double tabBarHeight = 46;
  static const double tabBarIndicatorWeight = 2;

  static const double textFieldHeight = 48;
  static const double textFieldPaddingVertical = 8;
  static const double textFieldPaddingHorizontal = 20;
  static const double textFieldRadius = textFieldHeight / 2;

  static const double iconButtonSize = 50;
  static const double iconButtonElevation = 4;

  static const double iconSizeLowest = 15;
  static const double iconSizeLow = 20;
  static const double iconSize = 30;
  static const double iconSizeNormal = 40;
  static const double iconSizeHigh = 50;

  static const double logoSize = 40;
  static const double logoSizeHigh = 50;

  static const double splashLogoAspectRatio = 4;
  static const double splashLogoWidthFactor = 0.50;

  static const double loginBackgroundOpacity = 0.95;
  static const double loginLogoAspectRatio = splashLogoAspectRatio;
  static const double loginLogoWidthFactor = splashLogoWidthFactor;

  static const double emptySizeMin = 5;
  static const double emptySizeLowest = 10;
  static const double emptySizeLow = 20;
  static const double emptySize = 30;
  static const double emptySizeMedium = 40;
  static const double emptySizeHigh = 50;
  static const double emptySizeHighest = 60;

  // Durations
  static const int durationLowest = 200;
  static const int durationNormal = 250;
  static const int durationLow = 300;
  static const int durationMedium = 500;
  static const int durationHigh = 700;

  static const int animationDurationNormal = 2000;
  static const int animationDurationHigh = 3000;

  // filters
  static const double filterNumber = 8.0;

  // Border Radius Sizes
  static const double radiusLowest = 10.0;
  static const double radiusLow = 20.0;
  static const double radius = 25.0;
  static const double radiusMedium = 40.0;
  static const double radiusHigh = 50.0;
  static const double radiusHighest = 100.0;

  // Opacity
  static const double opacityLowest = 0.1;
  static const double opacityLow = 0.3;
  static const double opacityNormal = 0.4;
  static const double opacityMedium = 0.5;
  static const double opacityHigh = 0.7;
  static const double opacityHighest = 0.9;

  // Alert Icon Sizes
  static const double alertIconSizeLow = 100;
  static const double alertIconSize = 200;
  static const double alertIconSizeHigh = 200;

  // Login Phone Number Max Limit
  static const int phoneNumberMaxLimit = 8;
  static const int phoneCodeNumberMaxLimit = 4;

  // Custom font sizes
  static const double smallestFontSize = 8.0;
  static const double smallFontSize = 9.0;
  static const double captionFontSize = 10.0;
  static const double labelFontSize = 12.0;
  static const double bodyFontSize = 14.0;
  static const double titleFontSize = 16.0;
  static const double headlineFontSize = 18.0;

  // Products
  static const double itemHeight = 0.25;

  static const double containerHeightRateLowest = 0.1;
  static const double containerHeightRateLow = 0.2;
  static const double containerHeightRateLowMedium = 0.3;
  static const double containerHeightRateNormal = 0.45;
  static const double containerHeightRate = 0.5;
  static const double containerHeightRateMedium = 0.6;

  static const double one = 1.0;
  static const double zero = 0.0;

  static const double buttonHeight = 50;
  static const double buttonSmallScreenHeight = 40;
  static const double estimationAddDoorButtonWidth = 180.0;

  static const int crossAxisCount = 2;
  static const int maxOneLines = 1;

  static int subImageMaxShowLimit = 2;

  static const SliverGridDelegate sliverGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 0.85,
  );

  static List<Color> gradientColors = <Color>[
    AppColors.customButton.withOpacity(0.0),
    AppColors.customButton.withOpacity(0.3),
    AppColors.customButton.withOpacity(0.7),
    AppColors.customButton.withOpacity(1.0),
  ];

  static List<double> gradientColorStops = <double>[0.0, 0.5, 0.8, 1.0];
}
