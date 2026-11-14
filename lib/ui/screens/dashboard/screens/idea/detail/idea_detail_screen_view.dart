import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/idea/detail/idea_detail.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../base_screen_view.dart';
import 'idea_detail_screen_args.dart';
import 'idea_detail_screen_controller.dart';

const double _thickness = 8.0;
const double _topPadding = 40.0;

@RoutePage()
final class IdeaDetailScreenView extends BaseScreenView<IdeaDetailScreenController, IdeaDetailScreenArgs> {
  const IdeaDetailScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<IdeaDetailScreenView> createState() => _IdeaDetailScreenViewState();
}

final class _IdeaDetailScreenViewState extends BaseScreenViewState<IdeaDetailScreenView, IdeaDetailScreenController, IdeaDetailScreenArgs> {
  @override
  Scaffold builder(BuildContext context, IdeaDetailScreenController controller) {
    final Size screenSize = MediaQuery.of(context).size;
    final double imageSize = screenSize.height * AppSize.containerHeightRateLowest;
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Obx(
            controller.ideaDetail,
            builder: (BuildContext context, Rxn<IdeaDetailResponseModel> ideaDetail, Widget? child) {
              if (ideaDetail.value == null) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MultiStyleText(
                        textAlign: TextAlign.center,
                        firstText: TextConstants.idea,
                        secondText: TextConstants.notfound,
                        firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                        secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                      ),
                      SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                      RefreshIconView(onTap: controller.fetchIdeaDetail),
                    ],
                  ),
                );
              }

              final List<ImageModel> images = ideaDetail.value!.data.idea.images ?? <ImageModel>[];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSize.paddingLow, top: _topPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.radiusHigh),
                      color: AppColors.background,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(AppSize.padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: context.dh(AppSize.containerHeightRateMedium),
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(AppSize.radiusHigh),
                                      child: switch (images.isNotEmpty) {
                                        true => CustomImageNetwork(
                                          ideaDetail.value!.data.idea.images!.first.url ?? '',
                                        ),
                                        false => const Placeholder(),
                                      },
                                    ),

                                    if (images.isNotEmpty && images.length > AppSize.subImageMaxShowLimit)
                                      Positioned(
                                        bottom: AppSize.emptySizeLow + imageSize + AppSize.paddingLow,
                                        right: AppSize.emptySizeLow,
                                        child: Container(
                                          height: imageSize,
                                          width: imageSize,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.radiusLow),
                                            color: AppColors.background,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(AppSize.paddingLowest),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(AppSize.radiusLow),
                                              child: switch (images.isNotEmpty) {
                                                true => CustomImageNetwork(
                                                  images[AppSize.subImageMaxShowLimit].url ?? '',
                                                ),
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
                                          height: imageSize,
                                          width: imageSize,
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
                                                if (images.length > AppSize.subImageMaxShowLimit)
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(AppSize.radiusLow),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: <Color>[
                                                          AppColors.gradientShadow,
                                                          AppColors.gradientShadow.withOpacity(0.7),
                                                          AppColors.gradientShadow.withOpacity(0.4),
                                                          Colors.transparent,
                                                        ],
                                                        stops: const <double>[0.0, 0.4, 0.7, 1.0],
                                                      ),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: AppColors.gradientShadow.withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: const Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (images.length > AppSize.subImageMaxShowLimit)
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '+${images.length - 2}',
                                                        style: AppTextStyles.headlineMedium(color: AppColors.onPrimary, fontSize: AppSize.headlineFontSize),
                                                      ),
                                                    ),
                                                  ),
                                              ],
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
                                child: Text(
                                  ideaDetail.value?.data.idea.title ?? '',
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
                                      ideaDetail.value?.data.idea.category?.name ?? '',
                                      style: AppTextStyles.labelSmall(
                                        fontFamily: fontFamilyRaleway,
                                        color: AppColors.inverseSurface,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: <Widget>[
                                        AppIcons.location(
                                          size: AppSize.iconSizeLowest,
                                        ),
                                        Text(
                                          '4 season',
                                          style: AppTextStyles.labelSmall(
                                            fontFamily: fontFamilyRaleway,
                                            color: AppColors.inverseSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSize.emptySizeLowest),
                            ],
                          ),
                        ),

                        const Divider(thickness: _thickness, color: AppColors.ideaBackground),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh),
                          child: Text(
                            TextConstants.description,
                            style: AppTextStyles.headlineMedium(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSize.headlineFontSize,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.padding),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.ideaBackground,
                                width: AppSize.one,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.radius),
                                topRight: Radius.circular(AppSize.radius),
                              ),
                            ),
                            padding: const EdgeInsets.all(AppSize.padding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Text(
                                  '${TextConstants.sizeLabel}: ${ideaDetail.value?.data.idea.size?.value}${ideaDetail.value?.data.idea.size?.unit}',
                                  style: AppTextStyles.headlineMedium(color: AppColors.onSecondary, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: AppSize.emptySizeLowest),

                                Html(data: ideaDetail.value?.data.idea.description ?? ''),
                                // Text(
                                //   ideaDetail.value?.data.idea.description ?? '',
                                //   style: AppTextStyles.bodyMedium(color: AppColors.inverseSurface, fontWeight: FontWeight.w400),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh),
                          child: Text(
                            TextConstants.calculation,
                            style: AppTextStyles.headlineMedium(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSize.headlineFontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.padding),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: AppSize.one,
                              ),
                              borderRadius: BorderRadius.circular(AppSize.radius),
                            ),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children:
                                      controller.ideaDetail.value?.data.idea.addItem?.map((AddItem addItem) {
                                        final AddItem item = addItem;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: AppSize.paddingNormal,
                                            right: AppSize.paddingNormal,
                                            top: AppSize.padding,
                                          ),
                                          child: titleRow(
                                            title: item.itemName ?? '',
                                            size: item.itemQuantity.toString(),
                                            price: '${item.itemPrice}₮',
                                          ),
                                        );
                                      }).toList() ??
                                      <Widget>[],
                                ),
                                const SizedBox(height: AppSize.emptySizeLowest),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(AppSize.radius),
                                      bottomRight: Radius.circular(AppSize.radius),
                                    ),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(AppSize.paddingHigh),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                          TextConstants.totalLabel,
                                          style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                                        ),

                                        Text(
                                          '${ideaDetail.value?.data.idea.totalCost}₮',
                                          style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const Positioned(
            top: AppSize.emptySizeHighest,
            left: AppSize.emptySize,
            child: CustomBackButton(),
          ),
        ],
      ),
    );
  }
}

Widget titleRow({
  required String title,
  required String size,
  required String price,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Text(
          title,
          style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
        ),
      ),

      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              size,
              style: AppTextStyles.bodyMedium(color: AppColors.inverseSurface),
            ),
          ],
        ),
      ),

      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              price,
              style: AppTextStyles.bodyMedium(color: AppColors.inverseSurface),
            ),
          ],
        ),
      ),
    ],
  );
}
