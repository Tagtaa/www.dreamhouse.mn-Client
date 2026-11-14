import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../../components/widgets/textfields/search_text_field.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_view.dart';
import '../../idea/widget/scroll_button_category.dart';
import '../widget/material_item.dart';
import '../widget/material_searched_item.dart';
import 'material_list_screen_controller.dart';

@RoutePage()
final class MaterialScreenWrapperView extends AutoRouter {
  MaterialScreenWrapperView({super.key}) : super(navigatorKey: AppNavigation.materialNavigatorKey);
}

@RoutePage()
final class MaterialListScreenView extends BaseScreenView<MaterialListScreenController, DefaultScreenArgs> {
  const MaterialListScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<MaterialListScreenView> createState() => _MaterialListScreenViewState();
}

final class _MaterialListScreenViewState extends BaseScreenViewState<MaterialListScreenView, MaterialListScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, MaterialListScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
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
                        controller.materials,
                        builder: (BuildContext context, Rx<List<MaterialItem>> materialItemList, Widget? child) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            child: materialItemList.value.isEmpty
                                ? Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        MultiStyleText(
                                          textAlign: TextAlign.center,
                                          firstText: TextConstants.materials,
                                          secondText: TextConstants.notfound,
                                          firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                                          secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                                        ),
                                        SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                                        RefreshIconView(onTap: controller.refresh),
                                      ],
                                    ),
                                  )
                                : AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    switchInCurve: Curves.easeIn,
                                    switchOutCurve: Curves.easeOut,
                                    child: switch (currentQuery.value.isEmpty) {
                                      true => ListView.builder(
                                        controller: controller.scrollController,
                                        itemCount: materialItemList.value.length + (controller.isLoadingMore.value ? 1 : 0),
                                        padding: const EdgeInsets.all(AppSize.paddingZero),
                                        itemBuilder: (BuildContext context, int index) {
                                          if (index == materialItemList.value.length) {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(vertical: AppSize.padding * 1.5),
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            );
                                          }
                                          return MaterialItemCard(
                                            materialItem: materialItemList.value[index],
                                            toggleOnLike: (String id) => controller.toggleLike(id),
                                          );
                                        },
                                      ),
                                      false => MasonryGridView.builder(
                                        controller: controller.scrollController,
                                        padding: const EdgeInsets.symmetric(vertical: AppSize.paddingZero, horizontal: AppSize.paddingLow),
                                        itemCount: materialItemList.value.length,
                                        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: AppSize.crossAxisCount,
                                        ),
                                        mainAxisSpacing: AppSize.padding,
                                        crossAxisSpacing: AppSize.padding,
                                        itemBuilder: (BuildContext context, int index) {
                                          if (index == materialItemList.value.length) {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(vertical: AppSize.padding * 1.5),
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            );
                                          }

                                          final MaterialItem material = materialItemList.value[index];
                                          return MaterialSearchedItem(material: material);
                                        },
                                      ),
                                    },
                                  ),
                          );
                        },
                      ),
                    ),
                  ),

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
                          color: AppColors.secondaryBackground,
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

                  Positioned(
                    top: currentQuery.value.isNotEmpty ? 56.0 : 0.0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: AppSize.emptySizeLow),
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            left: AppSize.padding,
                            right: AppSize.padding,
                            top: isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHighest,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: SearchTextField(
                                  //isReadOnly: true,
                                  controller: controller.searchController,
                                  hintText: TextConstants.searchMaterials,
                                  backgroundColor: AppColors.background,
                                  //onTap: () => AppNavigation.gotoMaterialSearchRoute(context),
                                  isMaterialField: true,
                                ),
                              ),
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
                              <RxBase>[controller.selectedIndex, controller.materialsCategories],
                              builder: (BuildContext context, Widget? child) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(AppSize.paddingZero),
                                  itemCount: controller.materialsCategories.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ScrollButtonCategoryView(
                                      materialCategory: controller.materialsCategories.value[index],
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
