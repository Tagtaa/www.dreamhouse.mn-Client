import 'package:flutter/material.dart';
import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/gesture_detector.dart';
import '../score_and_favorite_view.dart';

const double _thickness = 1.0;

const double _dividerWidth = 60.0;
const double _dividerHeight = 4.0;
const double _radiusSize = 3.0;
double progress = 0.7;

class MaterialItemCard extends StatefulWidget {
  final MaterialItem materialItem;
  final void Function(String id) toggleOnLike;

  const MaterialItemCard({
    super.key,
    required this.materialItem,
    required this.toggleOnLike,
  });

  @override
  State<MaterialItemCard> createState() => _MaterialItemCardState();
}

class _MaterialItemCardState extends State<MaterialItemCard> {
  bool _showDetail = false;

  void toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.paddingLow),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.radiusHigh),
          color: AppColors.background,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSize.paddingLow),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
                    child: Column(
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
                                child: switch (widget.materialItem.images != null && widget.materialItem.images!.isNotEmpty) {
                                  true => CustomImageNetwork(widget.materialItem.images!.first),
                                  false => const Placeholder(),
                                },
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

                        Text(
                          widget.materialItem.name ?? '',
                          style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w700),
                        ),

                        Row(
                          children: <Widget>[
                            Text(
                              '${widget.materialItem.price}₮',
                              style: AppTextStyles.headlineMedium(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              '1 ${TextConstants.onePiece} / ${widget.materialItem.length}x${widget.materialItem.width}x${widget.materialItem.height}${widget.materialItem.unit}',
                              style: AppTextStyles.labelSmall(
                                color: AppColors.inverseSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.emptySizeLowest),
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondaryBackground,
                        width: AppSize.one,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomGestureDetector(
                              onTap: toggleDetail,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.paddingLow,
                                  horizontal: AppSize.padding,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.article_outlined,
                                      size: AppSize.iconSizeLowest,
                                      color: AppColors.onSurface,
                                    ),
                                    const SizedBox(width: AppSize.emptySizeLowest),
                                    Text(
                                      TextConstants.detail,
                                      style: AppTextStyles.labelSmall(
                                        color: AppColors.onSurface,
                                        fontSize: AppSize.bodyFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const VerticalDivider(
                            thickness: _thickness,
                            color: AppColors.secondaryBackground,
                            width: AppSize.one,
                          ),

                          Expanded(
                            child: CustomGestureDetector(
                              onTap: () {},

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.paddingLow,
                                  horizontal: AppSize.padding,
                                ),
                                child: CustomGestureDetector(
                                  onTap: () => widget.toggleOnLike(widget.materialItem.id ?? ''),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        widget.materialItem.isLiked ?? false ? Icons.favorite : Icons.favorite_border_outlined,
                                        size: AppSize.iconSizeLowest,
                                        color: widget.materialItem.isLiked ?? false ? AppColors.primary : AppColors.surface,
                                      ),
                                      const SizedBox(width: AppSize.emptySizeLowest),
                                      Text(
                                        widget.materialItem.isLiked ?? false ? TextConstants.unlike : TextConstants.like,
                                        style: AppTextStyles.labelMedium(
                                          color: AppColors.onSurface,
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
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: AppSize.durationLow),
                    child: _showDetail
                        ? Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(AppSize.padding),
                                child: Text(widget.materialItem.description ?? ''),
                              ),
                              const SizedBox(height: AppSize.paddingLow),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            ScoreAndFavoriteView(
              like: widget.materialItem.likeCount ?? 0,
              rating: widget.materialItem.rating?.toDouble() ?? 0.0,
              rightPadding: AppSize.paddingHighest,
              topPadding: AppSize.paddingHigh,
              iconSize: AppSize.icon,
              radiusSize: AppSize.radius,
              fontSize: AppSize.bodyFontSize,
              padding: isSmallScreen ? AppSize.paddingLowest : AppSize.padding,
            ),
          ],
        ),
      ),
    );
  }
}
