// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'app_colors.dart';

const String fontFamily = 'Lato';
const String fontFamilyRaleway = 'Raleway';

enum AppTextStyles {
  // Display texts
  displayLarge(
    fontSize: 36,
    color: AppColors.splashText,
    fontWeight: FontWeight.w700, // Lato-Bold
  ),

  // Headline texts
  headlineLarge(
    fontSize: 25,
    color: AppColors.secondary,
    fontWeight: FontWeight.w800, // Lato-Extra-bold
  ),

  headlineMedium(
    fontSize: 25,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w500, // Lato-Medium
  ),

  // Title texts
  titleLarge(
    fontSize: 16,
    color: AppColors.surface,
    fontWeight: FontWeight.w400, // Lato-regular
  ),

  titleMedium(
    fontSize: 12,
    color: AppColors.onSecondary,
    fontWeight: FontWeight.w700, // Lato-Bold
  ),

  // // Body texts
  // bodyLarge(
  //   fontSize: 16,
  //   color: AppColors.onSurfaceHigh,
  //   fontWeight: FontWeight.w400, // Lato-Regular
  // ),

  bodyMedium(
    fontSize: 12,
    color: AppColors.onSecondary,
    fontWeight: FontWeight.w600, // Lato-Semi-bold
  ),

  // bodySmall(
  //   fontSize: 14,
  //   color: AppColors.onSurfaceLow,
  //   fontWeight: FontWeight.w400, // Lato-Regular
  // ),

  // // Label texts
  // labelLarge(
  //   fontSize: 16,
  //   color: AppColors.primary,
  //   fontWeight: FontWeight.w600, // Lato-SemiBold
  // ),

  labelMedium(
    fontSize: 14,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w700, // Lato-Bold
  ),

  labelSmall(
    fontSize: 12,
    color: AppColors.onPrimary,
    fontWeight: FontWeight.w400, // Lato-Medium
  ),

  // Specific use cases
  buttonText(
    fontSize: 16,
    color: AppColors.buttonText,
    fontWeight: FontWeight.w700, // Lato-Bold
  ),

  captionText(
    fontSize: 10,
    color: AppColors.inverseSurface,
    fontWeight: FontWeight.w500, // Lato-Medium
  );

  // Error and success texts
  // errorText(
  //   fontSize: 12,
  //   color: AppColors.error,
  //   fontWeight: FontWeight.w400, // Lato-Regular
  // ),

  // // Link texts
  // linkText(
  //   fontSize: 14,
  //   color: AppColors.primary,
  //   fontWeight: FontWeight.w500, // Lato-Medium
  // );

  final int fontSize;
  final Color color;
  final FontWeight fontWeight;

  const AppTextStyles({
    required this.fontSize,
    this.color = AppColors.surface,
    this.fontWeight = FontWeight.w400,
  });

  TextStyle call({
    Color? color,
    String? fontFamily = fontFamily,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? this.fontSize.toDouble(),
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle,
    );
  }
}
