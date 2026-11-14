// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/choose_thickness_item.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../base_screen_view.dart';
import 'choose_thickness_screen_args.dart';
import 'custom_choose_thickness_screen_controller.dart';

@RoutePage()
final class CustomChooseThicknessScreenView extends BaseScreenView<CustomChooseThicknessScreenController, ChooseThicknessScreenArgs> {
  const CustomChooseThicknessScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<CustomChooseThicknessScreenView> createState() => _CustomChooseThicknessScreenViewState();
}

final class _CustomChooseThicknessScreenViewState extends BaseScreenViewState<CustomChooseThicknessScreenView, CustomChooseThicknessScreenController, ChooseThicknessScreenArgs> {
  @override
  Scaffold builder(BuildContext context, CustomChooseThicknessScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: AppSize.paddingNormal,
          vertical: AppSize.paddingHighest,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: CustomBackButton(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    TextConstants.wallThickness,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: AppSize.emptySizeLow),

            Expanded(
              child: Obx.multiple(
                <RxBase>[
                  controller.selectedIndex,
                  controller.chooseThicknessLists,
                ],
                builder: (BuildContext context, Widget? child) {
                  if (controller.chooseThicknessLists.value.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.chooseThickness,
                            secondText: TextConstants.notfound,
                            firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                            secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                          ),
                          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                          RefreshIconView(onTap: controller.fetchCustomThickness),
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: AppSize.sliverGridDelegate,
                    itemCount: controller.chooseThicknessLists.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChooseThicknessItem(
                        chooseThickness: controller.chooseThicknessLists.value[index],
                        isSelected: controller.selectedIndex.value == index,
                        onItemTap: () {
                          controller.selectItemIndex(index);
                          controller.onItemTap?.call(controller.chooseThicknessLists.value[index]);
                          Future<void>.delayed(const Duration(milliseconds: AppSize.durationLow), () {
                            AppNavigation.popRoute(context);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
