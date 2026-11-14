import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/idea/list/idea_list_model.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/gesture_detector.dart';

class IdeaSearchedItem extends StatelessWidget {
  const IdeaSearchedItem({
    super.key,
    required this.idea,
  });

  final IdeaItem idea;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () => AppNavigation.gotoIdeaDetailRoute(context, ideaId: idea.id ?? ''),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(
            AppSize.radius,
          ),
        ),
        padding: const EdgeInsets.all(AppSize.paddingLow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: context.dh(AppSize.containerHeightRateLow),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.radius),
                child: switch (idea.images != null && idea.images!.isNotEmpty) {
                  true => CustomImageNetwork(idea.images!.first.url ?? ''),
                  false => const Placeholder(),
                },
              ),
            ),

            const SizedBox(height: AppSize.emptySizeLowest),

            Text(
              idea.title ?? '',
              style: AppTextStyles.titleMedium(),
            ),
            const SizedBox(height: AppSize.emptySizeLowest),

            Row(
              children: <Widget>[
                AppIcons.list(color: AppColors.secondary),
                const SizedBox(width: AppSize.emptySizeMin),
                Expanded(
                  child: Text(
                    idea.category?.name ?? '',
                    style: AppTextStyles.labelSmall(
                      color: AppColors.inverseSurface,
                      fontSize: AppSize.smallestFontSize,
                    ),
                    maxLines: AppSize.maxOneLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppIcons.location(
                        size: AppSize.iconSizeLowest,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${idea.shortDetail}',
                          maxLines: 2,
                          style: AppTextStyles.labelSmall(
                            color: AppColors.inverseSurface,
                            fontSize: AppSize.smallestFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.emptySizeLowest),

            Text(
              '${idea.totalCost} ₮',
              style: AppTextStyles.labelSmall(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSize.emptySizeLowest),
          ],
        ),
      ),
    );
  }
}
