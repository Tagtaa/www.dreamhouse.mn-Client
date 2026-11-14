import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/models/materials/list/material_list_model.dart';
import '../../screens/dashboard/screens/material/score_and_favorite_view.dart';
import 'custom_image_network.dart';
import 'gesture_detector.dart';

const double _fontSize = 8.0;
const double _fontTitleSize = 11.0;
const double _bottomSize = 60.0;

class ChooseMaterialItem extends StatelessWidget {
  const ChooseMaterialItem({
    super.key,
    required this.materialItem,
    this.isSelected = false,
    this.onItemTap,
  });

  final MaterialItem? materialItem;
  final bool isSelected;
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
              child: switch (materialItem?.images != null && materialItem!.images!.first.isNotEmpty) {
                true => CustomImageNetwork(materialItem!.images!.first),
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

            ScoreAndFavoriteView(
              like: materialItem?.likeCount ?? 0,
              rating: materialItem?.rating?.toDouble() ?? 0.0,
              rightPadding: AppSize.padding,
              topPadding: AppSize.padding,
            ),

            Positioned(
              bottom: _bottomSize,
              left: AppSize.padding,
              right: AppSize.padding,
              child: Text(
                materialItem?.name ?? '',
                style: AppTextStyles.bodyMedium(
                  fontSize: _fontTitleSize,
                  color: AppColors.buttonText,
                ),
              ),
            ),

            Positioned(
              bottom: AppSize.paddingHigh,
              left: AppSize.padding,
              child: Text(
                '${(materialItem?.price) ?? 0.0}₮',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.buttonText,
                ),
              ),
            ),

            Positioned(
              bottom: AppSize.paddingNormal,
              left: AppSize.padding,
              child: Text(
                '1 ${TextConstants.onePiece} / ${materialItem?.length}x${materialItem?.width}x${materialItem?.height}${materialItem?.unit}',
                style: AppTextStyles.bodyMedium(
                  fontSize: _fontSize,
                  color: AppColors.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
