// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/materials/category/material_category_model.dart';
import '../../../../../components/widgets/gesture_detector.dart';

const List<String> scrollingIdeaType = TextConstants.scrollingIdeaType;
const List<String> scrollingMaterialType = TextConstants.scrollingMaterialType;

class ScrollButtonCategoryView extends StatelessWidget {
  const ScrollButtonCategoryView({
    super.key,
    required this.materialCategory,
    required this.isSelected,
    this.backgroundColor = AppColors.secondaryBackground,
    required this.onSelected,
  });

  final MaterialCategory materialCategory;
  final bool isSelected;
  final Color backgroundColor;
  final void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onSelected.call,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSize.paddingLow),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.onSurface : backgroundColor,
            borderRadius: BorderRadius.circular(AppSize.radiusLow),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.paddingLowest, horizontal: AppSize.paddingHigh),
              child: Text(
                materialCategory.nameMn,
                style: AppTextStyles.captionText(
                  color: isSelected ? AppColors.secondaryBackground : AppColors.onSurface,
                  fontFamily: fontFamilyRaleway,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
