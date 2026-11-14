import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/idea/list/idea_list_model.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/buttons/custom_icon_button.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../../components/widgets/textfields/search_text_field.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_view.dart';
import '../widget/idea_searched_item.dart';
import '../widget/scroll_button.dart';
import '../widget/idea_card.dart';
import 'idea_list_screen_controller.dart';

@RoutePage()
final class IdeaScreenWrapperView extends AutoRouter {
  IdeaScreenWrapperView({super.key}) : super(navigatorKey: AppNavigation.ideaNavigatorKey);
}

@RoutePage()
final class IdeaListScreenView extends BaseScreenView<IdeaListScreenController, DefaultScreenArgs> {
  const IdeaListScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<IdeaListScreenView> createState() => _IdeaListScreenViewState();
}

final class _IdeaListScreenViewState extends BaseScreenViewState<IdeaListScreenView, IdeaListScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, IdeaListScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      backgroundColor: AppColors.ideaBackground,
      body: Obx(
        controller.scrollOffset,
        builder: (BuildContext context, Rx<double> scrollOffset, Widget? child) {
          return Obx(
            controller.currentQuery,
            builder: (BuildContext context, Rx<String> currentQuery, Widget? child) {
              final double baseHeaderHeight =
                  AppSize.emptySizeLow +
                  (isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHighest) +
                  56 +
                  (isSmallScreen ? AppSize.paddingLow : AppSize.padding) * 2 +
                  AppSize.buttonSmallScreenHeight;

              final double searchResultHeaderHeight = currentQuery.value.isNotEmpty ? 56.0 : 0.0;

              final double searchCountHeight = currentQuery.value.isNotEmpty
                  ? (isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow) * 2 + AppSize.headlineFontSize + (isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow)
                  : 0.0;

              final double originalHeaderHeight = baseHeaderHeight + searchResultHeaderHeight + searchCountHeight;
              final double headerHeight = (originalHeaderHeight - scrollOffset.value).clamp(0, originalHeaderHeight);

              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    top: headerHeight,
                    left: 0,
                    right: 0,
                    child: RefreshIndicator(
                      onRefresh: controller.refresh,
                      color: AppColors.primary,
                      child: Obx(
                        controller.ideas,
                        builder: (BuildContext context, Rx<List<IdeaItem>> ideasLists, Widget? child) {
                          if (ideasLists.value.isEmpty) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MultiStyleText(
                                    textAlign: TextAlign.center,
                                    firstText: TextConstants.ideas,
                                    secondText: TextConstants.notfound,
                                    firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                                    secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                                  ),
                                  SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                                  RefreshIconView(onTap: controller.refresh),
                                ],
                              ),
                            );
                          }
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            child: switch (currentQuery.value.isEmpty) {
                              true => ListView.builder(
                                controller: controller.scrollController,
                                itemCount: ideasLists.value.length + (controller.isLoadingMore.value ? 1 : 0),
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
                                  return IdeaCard(
                                    idea: ideasLists.value[index],
                                    onPurchase: () => controller.onPurchase(ideasLists.value[index].id ?? ''),
                                  );
                                },
                              ),
                              false => MasonryGridView.builder(
                                controller: controller.scrollController,
                                padding: const EdgeInsets.symmetric(vertical: AppSize.paddingZero, horizontal: AppSize.padding),
                                itemCount: ideasLists.value.length,
                                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: AppSize.crossAxisCount,
                                ),
                                mainAxisSpacing: AppSize.padding,
                                crossAxisSpacing: AppSize.padding,
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
                                  final IdeaItem idea = ideasLists.value[index];
                                  return IdeaSearchedItem(idea: idea);
                                },
                              ),
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Search result header - positioned at the very top when searching
                  Positioned(
                    top: currentQuery.value.isNotEmpty ? 56.0 : 0.0,
                    left: 0,
                    right: 0,
                    child: switch (currentQuery.value.isNotEmpty) {
                      true => Padding(
                        padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: AppSize.padding,
                        ),
                        child: Container(
                          height: 56.0,
                          color: AppColors.ideaBackground,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: CustomBackButton(onBack: () => controller.refreshSearchQuery()),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  TextConstants.searchResult,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.labelMedium(),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      false => const SizedBox.shrink(),
                    },
                  ),

                  // Main header - positioned below search result header when searching
                  Positioned(
                    top: currentQuery.value.isNotEmpty ? 56.0 : 0.0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: AppSize.emptySizeLow),
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppSize.padding,
                            right: AppSize.padding,
                            top: isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHighest,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: SearchTextField(
                                  controller: controller.searchController,
                                  //isReadOnly: true,
                                  hintText: TextConstants.searchIdeas,
                                  isMaterialField: currentQuery.value.isEmpty ? false : true,
                                  //onTap: () => AppNavigation.gotoIdeaSearchRoute(context),
                                ),
                              ),
                              switch (currentQuery.value.isEmpty) {
                                true => Row(
                                  children: <Widget>[
                                    const SizedBox(width: AppSize.emptySizeLow),
                                    CustomIconButton(
                                      icon: AppIcons.cart(color: AppColors.ideaIcon),
                                      isBorder: true,
                                      size: isSmallScreen ? AppSize.iconSize : AppSize.iconSizeNormal,
                                      onTap: () => AppNavigation.gotoPurchasedHistoryRoute(context),
                                    ),
                                  ],
                                ),
                                false => const SizedBox.shrink(),
                              },
                            ],
                          ),
                        ),

                        switch (currentQuery.value.isNotEmpty) {
                          true => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                                    Obx(
                                      controller.totalMaterials,
                                      builder: (BuildContext context, Rx<int> value, Widget? child) {
                                        return RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: TextConstants.found,
                                                style: AppTextStyles.headlineMedium(
                                                  color: AppColors.onSecondary,
                                                  fontSize: AppSize.headlineFontSize,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ${controller.totalMaterials.value} ',
                                                style: AppTextStyles.titleMedium(
                                                  color: AppColors.onSecondary,
                                                  fontSize: AppSize.headlineFontSize,
                                                ),
                                              ),
                                              TextSpan(
                                                text: TextConstants.article,
                                                style: AppTextStyles.headlineMedium(
                                                  color: AppColors.onSecondary,
                                                  fontSize: AppSize.headlineFontSize,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          false => const SizedBox.shrink(),
                        },

                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? AppSize.paddingLow : AppSize.padding,
                            horizontal: AppSize.padding,
                          ),
                          child: SizedBox(
                            height: AppSize.buttonSmallScreenHeight,
                            child: Obx.multiple(
                              <RxBase>[controller.selectedIndex, controller.ideasRanges],
                              builder: (BuildContext context, Widget? child) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(AppSize.paddingZero),
                                  itemCount: controller.ideasRanges.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ScrollButtonView(
                                      title: controller.ideasRanges.value[index].label,
                                      isSelected: controller.selectedIndex.value == index,
                                      backgroundColor: AppColors.background,
                                      onSelected: () => controller.changeSelectIndex(index),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
