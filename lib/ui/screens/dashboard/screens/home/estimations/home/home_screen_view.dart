import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../core/configs/constants/app_product_constants.dart';
import '../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../core/models/calculation/calculation_type_response_model.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../components/buttons/custom_icon_button.dart';
import '../../../../../../components/widgets/ellipse.dart';
import '../../../../../../components/widgets/multi_style_text.dart';
import '../../../../../../components/widgets/obx.dart';
import '../../../../../../components/widgets/refresh_icon.dart';
import '../../../../../base_screen_args.dart';
import '../../../../../base_screen_view.dart';
import '../../widget/estimation_type.dart';
import 'home_screen_controller.dart';

@RoutePage()
final class HomeScreenWrapperView extends AutoRouter {
  HomeScreenWrapperView({super.key}) : super(navigatorKey: AppNavigation.homeNavigatorKey);
}

@RoutePage()
final class HomeScreenView extends BaseScreenView<HomeScreenController, DefaultScreenArgs> {
  const HomeScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

final class _HomeScreenViewState extends BaseScreenViewState<HomeScreenView, HomeScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, HomeScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const EllipseView(),
          Padding(
            padding: const EdgeInsets.all(AppSize.paddingNormal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: context.isSmallScreen ? AppSize.emptySizeLow : AppSize.emptySizeHigh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    Expanded(
                      child: Text(
                        TextConstants.estimationTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelMedium(fontFamily: fontFamilyRaleway),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomIconButton(
                          icon: AppIcons.document(),
                          size: context.isSmallScreen ? AppSize.iconSizeNormal : AppSize.iconButtonSize,
                          onTap: () => AppNavigation.gotoCalculationHistoryRoute(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.emptySizeLow),
                Obx(
                  controller.typeList,
                  builder: (BuildContext context, Rx<List<CalculationType>> typeList, Widget? child) {
                    if (typeList.value.isEmpty) {
                      return Expanded(
                        child: Center(
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
                              RefreshIconView(onTap: controller.fetchTypes),
                            ],
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: AppSize.sliverGridDelegate,
                        itemCount: typeList.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CalculationType calculationType = typeList.value[index];
                          return EstimationTypeScreenView(
                            calculationType: calculationType,
                            route: AppProductConstants.wallEstimationRouteLists[index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
