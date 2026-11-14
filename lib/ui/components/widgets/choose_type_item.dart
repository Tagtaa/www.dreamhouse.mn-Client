import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/models/calculation/choose_type_response_model.dart';
import 'custom_image_network.dart';
import 'gesture_detector.dart';

class ChooseTypeItem extends StatelessWidget {
  const ChooseTypeItem({
    super.key,
    required this.chooseType,
    this.type,
    this.isLeftAlignText = false,
    this.isSelected = false,
    this.isOnlyShow = false,
    this.onItemTap,
  });

  final ChooseType? chooseType;
  final String? type;
  final bool isLeftAlignText;
  final bool isSelected;
  final bool isOnlyShow;
  final void Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () => onItemTap?.call(),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.radius),
              child: switch (chooseType?.imageUrl != null) {
                true => CustomImageNetwork(chooseType!.imageUrl!),
                false => const Placeholder(),
              },
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

            if (!isOnlyShow)
              Positioned(
                left: AppSize.padding,
                top: AppSize.padding,
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.customButton : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.paddingLow),
                    child: AppIcons.check(
                      color: isSelected ? AppColors.buttonText : AppColors.customButton,
                      applyColorFilter: true,
                      size: AppSize.iconSizeLowest,
                    ),
                  ),
                ),
              ),

            Positioned(
              bottom: isLeftAlignText ? AppSize.padding : AppSize.paddingHigh,
              left: AppSize.padding,
              right: isLeftAlignText ? null : AppSize.paddingLow,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  chooseType?.name ?? '',
                  style: AppTextStyles.buttonText(
                    fontWeight: FontWeight.w600,
                    fontSize: AppSize.labelFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
