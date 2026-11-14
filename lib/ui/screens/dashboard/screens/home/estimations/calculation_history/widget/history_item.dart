import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../../core/models/calculation/calculation_history_response_model.dart';
import '../../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../../components/widgets/custom_image_network.dart';
import '../calculation_history_detail_view.dart';

const double _emptySize = 5.0;
const double _imageHeight = 70.0;
const double _imageTabletHeight = 120.0;

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.history,
    required this.onDelete,
  });

  final CalculationHistory history;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppSize.radius),
      ),
      child: Slidable(
        key: Key(history.id.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.2,
          children: <Widget>[
            CustomSlidableAction(
              onPressed: (BuildContext context) => onDelete(),
              backgroundColor: AppColors.secondary,
              borderRadius: BorderRadius.circular(AppSize.radius),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppIcons.trash(size: AppSize.iconSizeLow),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.radius),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CalculationHistoryDetailView(calculationHistory: history),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: BorderRadius.circular(AppSize.radius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.paddingLow),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: context.isTablet ? _imageTabletHeight : _imageHeight,
                      width: context.isTablet ? _imageTabletHeight : _imageHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                        child: switch (history.materialImageUrl ?? history.inputs?.imageUrl) {
                          final String? imageUrl when imageUrl != null => CustomImageNetwork(imageUrl),
                          _ => const Placeholder(),
                        },
                      ),
                    ),
                    const SizedBox(width: AppSize.emptySizeLowest),
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.paddingLow),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            history.typeName ?? '',
                            style: AppTextStyles.titleMedium(
                              color: AppColors.onSurface,
                              fontFamily: fontFamilyRaleway,
                              fontSize: context.isTablet ? AppSize.bodyFontSize : AppSize.labelFontSize,
                            ),
                          ),
                          const SizedBox(height: _emptySize),
                          Text(
                            history.materialName ?? '',
                            style: AppTextStyles.captionText(
                              fontFamily: fontFamilyRaleway,
                              fontSize: context.isTablet ? AppSize.labelFontSize : AppSize.captionFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: AppSize.paddingLow, top: AppSize.paddingLow),
                      child: Text(
                        history.createdAt.timeAgo,
                        style: AppTextStyles.labelSmall(
                          color: AppColors.inverseSurface,
                          fontSize: context.isTablet ? AppSize.captionFontSize : AppSize.smallFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
