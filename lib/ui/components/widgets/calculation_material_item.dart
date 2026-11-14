import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/models/calculation/calculation_custom_model.dart';
import '../../../core/models/materials/list/material_list_model.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import 'custom_image_network.dart';

const double _fontSize = 8.0;
const double _fontTitleSize = 11.0;
const double _bottomSize = 60.0;

class CalculationMaterialItem extends StatelessWidget {
  const CalculationMaterialItem({
    super.key,
    this.selectedMaterialModel,
    this.calculationCustomModel,
  });

  final MaterialItem? selectedMaterialModel;
  final CalculationCustomModel? calculationCustomModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dh(AppSize.itemHeight),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radius),
            child: switch (calculationCustomModel != null && calculationCustomModel!.imageUrl != null && calculationCustomModel!.imageUrl!.isNotEmpty) {
              true => CustomImageNetwork(calculationCustomModel!.imageUrl!),
              false => switch (selectedMaterialModel?.images != null && selectedMaterialModel!.images!.isNotEmpty) {
                true => CustomImageNetwork(selectedMaterialModel!.images!.first),
                false => const Placeholder(),
              },
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
            bottom: _bottomSize,
            left: AppSize.padding,
            child: Text(
              calculationCustomModel != null ? 'Custom' : selectedMaterialModel?.name ?? '',
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
              calculationCustomModel != null ? '${calculationCustomModel!.price} ₮' : '${selectedMaterialModel?.price} ₮',
              style: AppTextStyles.bodyMedium(
                color: AppColors.buttonText,
              ),
            ),
          ),

          Positioned(
            bottom: AppSize.paddingNormal,
            left: AppSize.padding,
            child: Text(
              calculationCustomModel != null ? calculationCustomModel!.specs : '${selectedMaterialModel?.specs}',
              style: AppTextStyles.bodyMedium(
                fontSize: _fontSize,
                color: AppColors.buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
