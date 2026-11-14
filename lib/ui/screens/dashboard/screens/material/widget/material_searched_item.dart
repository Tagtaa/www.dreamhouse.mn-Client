import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../score_and_favorite_view.dart';

const double _radius = 15.0;

class MaterialSearchedItem extends StatelessWidget {
  const MaterialSearchedItem({
    super.key,
    required this.material,
  });

  final MaterialItem material;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(
          AppSize.radius,
        ),
      ),
      padding: const EdgeInsets.all(AppSize.paddingLow),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: context.dh(AppSize.containerHeightRateLow),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_radius),
                  child: switch (material.images != null && material.images!.isNotEmpty) {
                    true => CustomImageNetwork(material.images!.first),
                    false => const Placeholder(),
                  },
                ),
              ),

              const SizedBox(height: AppSize.emptySizeLowest),

              Text(
                material.name ?? '',
                style: AppTextStyles.titleMedium(),
              ),
              const SizedBox(height: AppSize.emptySizeLowest),

              Row(
                children: <Widget>[
                  AppIcons.list(color: AppColors.secondary),
                  const SizedBox(width: AppSize.emptySizeLowest),
                  Expanded(
                    child: Text(
                      material.category?.name ?? '',
                      style: AppTextStyles.labelSmall(
                        color: AppColors.inverseSurface,
                        fontSize: AppSize.smallestFontSize,
                      ),
                      maxLines: AppSize.maxOneLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.emptySizeLowest),

              Text(
                '${material.price} ₮',
                style: AppTextStyles.labelSmall(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLowest),
            ],
          ),
          ScoreAndFavoriteView(
            like: material.likeCount ?? 0,
            rating: material.rating?.toDouble() ?? 0.0,
            rightPadding: AppSize.padding,
            topPadding: AppSize.padding,
          ),
        ],
      ),
    );
  }
}
