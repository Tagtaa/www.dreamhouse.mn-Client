import '../widgets/gesture_detector.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';

final class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.onPrimary,
    this.size = AppSize.iconButtonSize,
    this.hasOpacityAnimation = true,
    this.isBorder = false,
  });

  final Widget icon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final double size;
  final bool hasOpacityAnimation;
  final bool isBorder;

  bool get isTransparent => backgroundColor == Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onTap,
      hasOpacityAnimation: hasOpacityAnimation,
      child: Material(
        color: backgroundColor,
        elevation: isTransparent ? 0 : AppSize.iconButtonElevation,
        shape: isTransparent
            ? const RoundedRectangleBorder()
            : CircleBorder(
                side: isBorder ? const BorderSide(color: AppColors.primary, width: 1.2) : BorderSide.none,
              ),
        child: SizedBox(
          width: size,
          height: size,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: icon,
          ),
        ),
      ),
    );
  }
}
