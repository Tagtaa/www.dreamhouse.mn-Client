import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static const ThemeMode themeMode = ThemeMode.light;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    // hintColor: AppColors.onSurfaceLow,
    fontFamily: fontFamily,

    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: AppColors.onSurfaceHigh,
    //   selectionColor: AppColors.primary,
    //   selectionHandleColor: AppColors.primary,
    // ),
    // popupMenuTheme: PopupMenuThemeData(
    //   color: AppColors.surface,
    //   elevation: 8,
    //   enableFeedback: tru"e,
    //   textStyle: AppTextStyles.body2_high(),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    // ),
    // dialogBackgroundColor: AppColors.surface,
    // dialogTheme: const DialogTheme(
    //   backgroundColor: AppColors.surface,
    // ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.light,
      //    background: AppColors.background,
      surface: AppColors.surface,
      primary: AppColors.primary,
      //      onBackground: AppColors.onSurfaceHigh,
      onSurface: AppColors.onSurface,
      onPrimary: AppColors.onPrimary,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      iconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.icon),
      actionsIconTheme: IconThemeData(size: 24, opacity: 1, color: AppColors.icon),
    ),
    // iconTheme: const IconThemeData(size: 24, opacity: 1, color: AppColors.onSurfaceHigh),
    // dividerTheme: const DividerThemeData(
    //   thickness: AppSize.dividerThickness,
    //   space: 0,
    //   color: AppColors.onSurfaceLow,
    // ),
    // badgeTheme: const BadgeThemeData(
    //   backgroundColor: AppColors.badge,
    // ),
    // bottomSheetTheme: const BottomSheetThemeData(
    //   elevation: 0,
    // ),
  );
}
