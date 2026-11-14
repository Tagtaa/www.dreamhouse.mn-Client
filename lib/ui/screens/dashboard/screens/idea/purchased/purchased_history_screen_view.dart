import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/idea/list/purchased_idea_list_model.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_view.dart';
import '../widget/purchased_idea_card.dart';
import 'purchased_history_screen_controller.dart';

@RoutePage()
final class PurchasedHistoryScreenView extends BaseScreenView<PurchasedHistoryScreenController, DefaultScreenArgs> {
  const PurchasedHistoryScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<PurchasedHistoryScreenView> createState() => _PurchasedHistoryScreenViewState();
}

final class _PurchasedHistoryScreenViewState extends BaseScreenViewState<PurchasedHistoryScreenView, PurchasedHistoryScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, PurchasedHistoryScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    final double originalHeaderHeight = (isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHighest) + 56 + (isSmallScreen ? AppSize.paddingLow : AppSize.padding) * 2;

    return Scaffold(
      backgroundColor: AppColors.ideaBackground,
      body: Obx(
        controller.scrollOffset,
        builder: (BuildContext context, Rx<double> scrollOffset, Widget? child) {
          final double headerHeight = (originalHeaderHeight - scrollOffset.value).clamp(0, originalHeaderHeight);

          return Stack(
            children: <Widget>[
              Positioned.fill(
                top: headerHeight,
                left: 0,
                right: 0,
                child: Obx(
                  controller.ideas,
                  builder: (BuildContext context, Rx<List<PurchasedIdeaItem>> ideasLists, Widget? child) {
                    if (ideasLists.value.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.purchasedIdeas,
                            secondText: TextConstants.notfound,
                            firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                            secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                          ),
                          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                          RefreshIconView(onTap: controller.fetchIdeas),
                        ],
                      );
                    }
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: ideasLists.value.length,
                      padding: const EdgeInsets.all(AppSize.paddingZero),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == ideasLists.value.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: AppSize.padding * 1.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }
                        return PurchasedIdeaCard(
                          idea: ideasLists.value[index],
                          isPurchased: true,
                        );
                      },
                    );
                  },
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: AppSize.emptySizeLow),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppSize.padding,
                        right: AppSize.padding,
                        top: isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHigh,
                      ),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: AppSize.paddingNormal,
                                vertical: AppSize.padding,
                              ),
                              child: CustomBackButton(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              TextConstants.purchasedItems,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.labelMedium(),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
