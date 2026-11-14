// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/choose_type_item.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/multi_style_text.dart';
import '../../../../../components/widgets/obx.dart';
import '../../../../../components/widgets/refresh_icon.dart';
import '../../../../base_screen_view.dart';
import 'choose_type_screen_args.dart';
import 'custom_choose_type_screen_controller.dart';

@RoutePage()
final class CustomChooseTypeScreenView extends BaseScreenView<CustomChooseTypeScreenController, ChooseTypeScreenArgs> {
  const CustomChooseTypeScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<CustomChooseTypeScreenView> createState() => _CustomChooseTypeScreenViewState();
}

final class _CustomChooseTypeScreenViewState extends BaseScreenViewState<CustomChooseTypeScreenView, CustomChooseTypeScreenController, ChooseTypeScreenArgs> {
  @override
  Scaffold builder(BuildContext context, CustomChooseTypeScreenController controller) {
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
                    controller.isLeftAlignText ? TextConstants.wallThickness : TextConstants.chooseType,
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
                  controller.chooseTypeLists,
                ],
                builder: (BuildContext context, Widget? child) {
                  if (controller.chooseTypeLists.value.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.chooseTypes,
                            secondText: TextConstants.notfound,
                            firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                            secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                          ),
                          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                          RefreshIconView(onTap: controller.fetchCustomTypes),
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: AppSize.sliverGridDelegate,
                    itemCount: controller.chooseTypeLists.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChooseTypeItem(
                        chooseType: controller.chooseTypeLists.value[index],
                        isLeftAlignText: controller.isLeftAlignText,
                        isSelected: controller.selectedIndex.value == index,
                        onItemTap: () {
                          controller.selectItemIndex(index);
                          controller.onItemTap?.call(controller.chooseTypeLists.value[index]);
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
