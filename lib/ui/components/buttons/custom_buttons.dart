import '../../../core/configs/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../widgets/gesture_detector.dart';

enum ButtonType {
  primaryLarge,
  secondaryLarge,
  primarySmall,
  secondarySmall,
  customPrimarySmall,
}

class ButtonConfig {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const ButtonConfig({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.borderWidth = 0,
  });
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final ButtonType type;
  final TextStyle? textStyle;
  final bool isEnabled;
  final bool hasOpacityAnimation;
  final double? width;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final bool isLongWidth;
  final bool isLongHeight;
  final IconData? icon;
  final bool isTablet;
  final bool isSmallScreen;

  const CustomButton({
    super.key,
    required this.text,
    required this.type,
    this.onTap,
    this.textStyle,
    this.isEnabled = true,
    this.hasOpacityAnimation = true,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.isLongWidth = false,
    this.isLongHeight = false,
    this.icon,
    this.isTablet = false,
    this.isSmallScreen = false,
  });

  ButtonConfig _getConfig() {
    switch (type) {
      case ButtonType.primaryLarge:
        return ButtonConfig(
          width: switch (isTablet) {
            true => isLongWidth ? 450 : 250,
            false => isLongWidth ? 278 : 190,
          },
          height: switch (isSmallScreen) {
            true => isLongHeight ? 52 : 44,
            false => isLongHeight ? 63 : 54,
          },
          borderRadius: 10,
          backgroundColor: AppColors.primary,
          textColor: AppColors.onPrimary,
        );
      case ButtonType.secondaryLarge:
        return ButtonConfig(
          width: switch (isTablet) {
            true => isLongWidth ? 450 : 250,
            false => isLongWidth ? 278 : 190,
          },
          height: switch (isSmallScreen) {
            true => isLongHeight ? 52 : 44,
            false => isLongHeight ? 63 : 54,
          },
          borderRadius: 10,
          backgroundColor: AppColors.onPrimary,
          textColor: AppColors.secondary,
          borderColor: AppColors.secondary,
          borderWidth: 2,
        );
      case ButtonType.primarySmall:
        return const ButtonConfig(
          width: 158.5,
          height: 70,
          borderRadius: 25,
          backgroundColor: AppColors.primary,
          textColor: AppColors.onPrimary,
        );
      case ButtonType.secondarySmall:
        return const ButtonConfig(
          width: 158.5,
          height: 70,
          borderRadius: 25,
          backgroundColor: AppColors.onPrimary,
          textColor: AppColors.primary,
        );

      case ButtonType.customPrimarySmall:
        return ButtonConfig(
          width: width ?? 158.5,
          height: height ?? 70,
          borderRadius: radius ?? 100,
          backgroundColor: backgroundColor ?? AppColors.primary,
          textColor: AppColors.onPrimary,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = _getConfig();

    return CustomGestureDetector(
      onTap: isEnabled ? onTap : null,
      hasOpacityAnimation: hasOpacityAnimation,
      child: Container(
        width: config.width,
        height: config.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(config.borderRadius),
          color: isEnabled ? config.backgroundColor : _getDisabledColor(config.backgroundColor),
          border: config.borderColor != null
              ? Border.all(
                  color: isEnabled ? config.borderColor! : Colors.grey,
                  width: config.borderWidth,
                )
              : null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
            child: Row(
              mainAxisAlignment: icon != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(
                    icon,
                    color: textStyle?.color ?? AppColors.buttonText,
                    size: AppSize.iconSizeLow,
                  ),
                ],
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ?? AppTextStyles.buttonText(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getDisabledColor(Color originalColor) {
    return originalColor.withOpacity(AppSize.opacityMedium);
  }
}

class AppButton {
  static Widget customPrimarySmall({
    required String text,
    VoidCallback? onTap,
    TextStyle? textStyle,
    bool isEnabled = true,
    bool hasOpacityAnimation = true,
    double width = 158.5,
    double height = 70,
    double radius = 10,
    Color backgroundColor = AppColors.primary,
    IconData? icon,
    bool isSmallScreen = false,
  }) {
    return CustomButton(
      text: text,
      type: ButtonType.customPrimarySmall,
      onTap: onTap,
      textStyle:
          textStyle ??
          AppTextStyles.buttonText(
            fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.titleFontSize,
          ),
      isEnabled: isEnabled,
      hasOpacityAnimation: hasOpacityAnimation,
      width: width,
      height: isSmallScreen ? 50 : height,
      radius: radius,
      backgroundColor: backgroundColor,
      icon: icon,
      isSmallScreen: isSmallScreen,
    );
  }

  static Widget primaryLarge({
    required String text,
    VoidCallback? onTap,
    AppTextStyles? textStyle,
    bool isEnabled = true,
    bool hasOpacityAnimation = true,
    bool isLongWidth = false,
    bool isLongHeight = false,
    bool isTablet = false,
    bool isSmallScreen = false,
  }) {
    return CustomButton(
      text: text.toUpperCase(),
      type: ButtonType.primaryLarge,
      onTap: onTap,
      textStyle:
          textStyle?.call() ??
          AppTextStyles.buttonText(
            fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.titleFontSize,
          ),
      isEnabled: isEnabled,
      isLongWidth: isLongWidth,
      isLongHeight: isLongHeight,
      hasOpacityAnimation: hasOpacityAnimation,
      isTablet: isTablet,
      isSmallScreen: isSmallScreen,
    );
  }

  static Widget secondaryLarge({
    required String text,
    VoidCallback? onTap,
    AppTextStyles? textStyle,
    bool isEnabled = true,
    bool hasOpacityAnimation = true,
    bool isLongWidth = false,
    bool isLongHeight = false,
    bool isTablet = false,
    bool isSmallScreen = false,
  }) {
    return CustomButton(
      text: text.toUpperCase(),
      type: ButtonType.secondaryLarge,
      onTap: onTap,
      textStyle:
          textStyle?.call() ??
          AppTextStyles.buttonText(
            color: AppColors.onSurface,
            fontSize: isSmallScreen ? AppSize.labelFontSize : AppSize.titleFontSize,
          ),
      isEnabled: isEnabled,
      isLongWidth: isLongWidth,
      isLongHeight: isLongHeight,
      hasOpacityAnimation: hasOpacityAnimation,
      isTablet: isTablet,
      isSmallScreen: isSmallScreen,
    );
  }

  static Widget primarySmall({
    required String text,
    VoidCallback? onTap,
    AppTextStyles? textStyle,
    bool isEnabled = true,
    bool hasOpacityAnimation = true,
  }) {
    return CustomButton(
      text: text.toUpperCase(),
      type: ButtonType.primarySmall,
      onTap: onTap,
      textStyle: textStyle?.call() ?? AppTextStyles.buttonText(),
      isEnabled: isEnabled,
      hasOpacityAnimation: hasOpacityAnimation,
    );
  }

  static Widget secondarySmall({
    required String text,
    VoidCallback? onTap,
    AppTextStyles? textStyle,
    bool isEnabled = true,
    bool hasOpacityAnimation = true,
  }) {
    return CustomButton(
      text: text.toUpperCase(),
      type: ButtonType.secondarySmall,
      onTap: onTap,
      textStyle: textStyle?.call() ?? AppTextStyles.buttonText(color: AppColors.onSecondary),
      isEnabled: isEnabled,
      hasOpacityAnimation: hasOpacityAnimation,
    );
  }
}
