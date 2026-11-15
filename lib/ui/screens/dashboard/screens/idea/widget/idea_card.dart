import 'package:flutter/material.dart';
import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/models/idea/list/idea_list_model.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/buttons/custom_buttons.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/fixed_lines_text.dart';

const double _buttonWidth = 240.0;
const double _buttonTabletWidth = 400.0;
const double _buttonHeight = 50.0;
const double _buttonSmallScreenHeight = 40.0;
const double _radius = 4.0;

const double _dividerWidth = 60.0;
const double _dividerHeight = 4.0;
const double _radiusSize = 3.0;
double progress = 0.7;

class IdeaCard extends StatelessWidget {
  final IdeaItem idea;
  final void Function()? onPurchase;

  const IdeaCard({
    super.key,
    required this.idea,
    this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isTablet = context.isTablet;

    final List<ImageModel> images = idea.images ?? <ImageModel>[];
    final bool isFreeOrPurchased = (idea.isPurchased ?? false) || (idea.purchasePrice ?? 0) == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.paddingLow),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.radiusHigh),
          color: AppColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingLow),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    AppImages.shape_stroke(
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.radiusHigh),
                      child: switch (images.isNotEmpty) {
                        true => CustomImageNetwork(images.first.url ?? ''),
                        false => const Placeholder(),
                      },
                    ),

                    if (images.isNotEmpty && images.length > AppSize.subImageMaxShowLimit)
                      Positioned(
                        bottom: AppSize.emptySizeLow + context.dh(AppSize.containerHeightRateLowest) + AppSize.paddingLow,
                        right: AppSize.emptySizeLow,
                        child: Container(
                          height: context.dh(AppSize.containerHeightRateLowest),
                          width: context.dh(AppSize.containerHeightRateLowest),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.radiusLow),
                            color: AppColors.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.paddingLowest),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.radiusLow),
                              child: switch (images.isNotEmpty) {
                                true => CustomImageNetwork(images[AppSize.subImageMaxShowLimit].url ?? ''),
                                false => const Placeholder(),
                              },
                            ),
                          ),
                        ),
                      ),

                    if (images.isNotEmpty && images.length >= AppSize.subImageMaxShowLimit)
                      Positioned(
                        bottom: AppSize.emptySizeLow,
                        right: AppSize.emptySizeLow,
                        child: Container(
                          height: context.dh(AppSize.containerHeightRateLowest),
                          width: context.dh(AppSize.containerHeightRateLowest),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.radiusLow),
                            color: AppColors.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.paddingLowest),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSize.radiusLow),
                                  child: switch (images.isNotEmpty) {
                                    true => CustomImageNetwork(images[1].url ?? ''),
                                    false => const Placeholder(),
                                  },
                                ),
                                if (images.length > AppSize.subImageMaxShowLimit + 1)
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.radiusLow),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          AppColors.gradientShadow,
                                          AppColors.gradientShadow.withOpacity(AppSize.opacityHigh),
                                          AppColors.gradientShadow.withOpacity(AppSize.opacityNormal),
                                          Colors.transparent,
                                        ],
                                        stops: const <double>[0.0, 0.4, 0.7, 1.0],
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: AppColors.gradientShadow.withOpacity(AppSize.opacityLow),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (images.length > AppSize.subImageMaxShowLimit + 1)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(_radius),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '+${idea.images!.length - 2}',
                                        style: AppTextStyles.headlineMedium(color: AppColors.onPrimary, fontSize: AppSize.headlineFontSize),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: AppSize.emptySize,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(_radiusSize),
                          child: SizedBox(
                            width: _dividerWidth,
                            height: _dividerHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: _dividerWidth * progress,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      _radiusSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(_radiusSize),
                                        bottomRight: Radius.circular(_radiusSize),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.emptySize),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                // Title always takes 3 lines so long titles don't move the rest of the card
                child: FixedLinesText(
                  idea.title ?? '',
                  style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w700),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                child: Row(
                  children: <Widget>[
                    AppIcons.list(color: AppColors.secondary),
                    const SizedBox(width: AppSize.emptySizeLowest),
                    Text(
                      idea.category?.name ?? '',
                      style: AppTextStyles.labelSmall(
                        fontFamily: fontFamilyRaleway,
                        color: AppColors.inverseSurface,
                      ),
                    ),
                    // const Spacer(),
                    // Text(
                    //   idea.subcategory ?? '',
                    //   style: AppTextStyles.labelSmall(
                    //     fontFamily: fontFamilyRaleway,
                    //     color: AppColors.inverseSurface,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLowest),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                child: Text(
                  TextConstants.materialCost,
                  style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLowest),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.radius),
                    color: AppColors.secondaryBackground,
                  ),
                  padding: const EdgeInsets.all(AppSize.paddingNormal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${idea.size?.value ?? ''}',
                            style: AppTextStyles.labelMedium(
                              fontSize: AppSize.headlineFontSize,
                            ),
                          ),
                          // Premium ideas: the API sends the total cost to buyers only
                          if (idea.totalCost != null)
                            Text(
                              '${idea.totalCost} ₮',
                              style: AppTextStyles.labelMedium(
                                fontSize: AppSize.headlineFontSize,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSize.emptySizeLowest),
                      Text(
                        idea.shortDetail ?? '',
                        style: AppTextStyles.labelSmall(
                          color: AppColors.inverseSurface,
                          fontSize: isTablet ? AppSize.labelFontSize : AppSize.smallFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLowest),

              switch (isFreeOrPurchased) {
                true => Center(
                  child: AppButton.customPrimarySmall(
                    backgroundColor: AppColors.secondary,
                    text: TextConstants.readMore,
                    radius: AppSize.radiusHighest,
                    width: isTablet ? _buttonTabletWidth : _buttonWidth,
                    height: isSmallScreen ? _buttonSmallScreenHeight : _buttonHeight,
                    onTap: () => AppNavigation.gotoIdeaDetailRoute(context, ideaId: idea.id ?? ''),
                  ),
                ),
                false => Center(
                  child: AppButton.customPrimarySmall(
                    text: '${TextConstants.purchaseWith} ${idea.purchasePrice?.toStringAsFixed(0)}₮',
                    radius: AppSize.radiusHighest,
                    width: isTablet ? _buttonTabletWidth : _buttonWidth,
                    height: isSmallScreen ? _buttonSmallScreenHeight : _buttonHeight,
                    onTap: () async {
                      await showIdeaAlertNotification(
                        context,
                        message: TextConstants.areYouSureToBuyThisItemWithAmount.replaceAll('{amount}', '${idea.purchasePrice?.toStringAsFixed(0)}₮'),
                        icon: AppImages.success_alert(),
                        isAutoDismiss: false,
                        isCallPop: false,
                        onButtonPressed: () => onPurchase?.call(),
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
