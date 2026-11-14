import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/utils/extensions/size_extensions.dart';

class ChooseGeneralItem extends StatelessWidget {
  const ChooseGeneralItem({
    super.key,
    required this.image,
    required this.title,
  });

  final AppImages image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dh(AppSize.itemHeight),

      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radius),
            child: image(fit: BoxFit.fill),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.radius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppSize.gradientColors,
                stops: AppSize.gradientColorStops,
              ),
            ),
          ),

          Positioned(
            left: AppSize.padding,
            top: AppSize.padding,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.customButton,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.paddingLow),
                child: AppIcons.check(
                  color: AppColors.buttonText,
                  applyColorFilter: true,
                  size: AppSize.iconSizeLowest,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: AppSize.paddingHigh,
            left: AppSize.padding,
            child: Text(
              title,
              style: AppTextStyles.bodyMedium(color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
