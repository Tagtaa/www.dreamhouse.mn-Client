import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Duration? duration,
    Color? backgroundColor,
    TextStyle? textStyle,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                message,
                style: textStyle ?? AppTextStyles.buttonText(),
              ),
            ),
          ],
        ),
        duration: duration ?? const Duration(milliseconds: AppSize.animationDurationNormal),
        backgroundColor: backgroundColor ?? AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
