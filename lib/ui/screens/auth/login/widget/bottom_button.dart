import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../components/buttons/custom_buttons.dart';

class BottomButtonWidget extends StatelessWidget {
  final bool isSmallScreen;
  final bool isTablet;
  final VoidCallback onTap;
  final String? buttonText;
  final bool? isLongWidth;
  final bool? isLongHeight;

  const BottomButtonWidget({
    super.key,
    required this.isSmallScreen,
    required this.isTablet,
    required this.onTap,
    this.buttonText,
    this.isLongWidth,
    this.isLongHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.paddingNormal),
      child: AppButton.primaryLarge(
        text: buttonText ?? TextConstants.continueText,
        isLongHeight: isLongHeight ?? !isSmallScreen,
        isSmallScreen: isSmallScreen,
        isLongWidth: isLongWidth ?? true,
        isTablet: isTablet,
        onTap: onTap,
      ),
    );
  }
}
