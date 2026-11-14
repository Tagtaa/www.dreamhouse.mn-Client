// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/choose_shape_item.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../base_screen_view.dart';
import 'choose_shapes_screen_args.dart';
import 'custom_choose_shapes_screen_controller.dart';

@RoutePage()
final class CustomChooseShapesScreenView extends BaseScreenView<CustomChooseShapesScreenController, ChooseShapesScreenArgs> {
  const CustomChooseShapesScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<CustomChooseShapesScreenView> createState() => _CustomChooseShapesScreenViewState();
}

final class _CustomChooseShapesScreenViewState extends BaseScreenViewState<CustomChooseShapesScreenView, CustomChooseShapesScreenController, ChooseShapesScreenArgs> {
  @override
  Scaffold builder(BuildContext context, CustomChooseShapesScreenController controller) {
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
                    TextConstants.chooseShape,
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
                  controller.chooseShapeLists,
                ],
                builder: (BuildContext context, Widget? child) {
                  if (controller.chooseShapeLists.value.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.chooseShapes,
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
                    itemCount: controller.chooseShapeLists.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChooseShapeItem(
                        chooseShape: controller.chooseShapeLists.value[index],
                        isSelected: controller.selectedIndex.value == index,
                        onItemTap: () {
                          controller.selectItemIndex(index);
                          controller.onItemTap?.call(controller.chooseShapeLists.value[index]);
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
