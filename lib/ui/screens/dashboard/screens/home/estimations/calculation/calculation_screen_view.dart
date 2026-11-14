import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../core/models/calculation/ing_calc_model.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../components/buttons/custom_buttons.dart';
import '../../../../../../components/buttons/custom_icon_button.dart';
import '../../../../../../components/widgets/calculation_material_item.dart';
import '../../../../../../components/widgets/calculation_type_item.dart';
import '../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../components/widgets/obx.dart';
import '../../../../../base_screen_view.dart';
import 'calculation_screen_args.dart';
import 'calculation_screen_controller.dart';

@RoutePage()
final class CalculationScreenView extends BaseScreenView<CalculationScreenController, CalculationScreenArgs> {
  const CalculationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<CalculationScreenView> createState() => _CalculationScreenViewState();
}

final class _CalculationScreenViewState extends BaseScreenViewState<CalculationScreenView, CalculationScreenController, CalculationScreenArgs> {
  @override
  Scaffold builder(BuildContext context, CalculationScreenController controller) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: AppSize.paddingNormal,
          vertical: AppSize.paddingHighest,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLowest),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CustomBackButton(),
                    Text(
                      TextConstants.calculation,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.labelMedium(),
                    ),
                    CustomIconButton(
                      icon: AppIcons.share(size: AppSize.iconSizeLowest),
                      size: context.isSmallScreen ? AppSize.iconSizeNormal : AppSize.iconButtonSize,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLow),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TextConstants.material,
                  style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLow),

              Row(
                children: <Widget>[
                  Expanded(
                    child: CalculationTypeItem(
                      image: controller.selectedTypeModel?.imageUrl ?? '',
                      title: controller.selectedThicknessModel?.name.toString() ?? '',
                      type: controller.selectedTypeModel?.name ?? '',
                    ),
                  ),

                  const SizedBox(width: AppSize.emptySizeLow),

                  Expanded(
                    child: CalculationMaterialItem(
                      selectedMaterialModel: controller.selectedMaterialModel,
                      calculationCustomModel: controller.calculationCustomModel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.emptySizeLow),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TextConstants.calculation,
                  style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                ),
              ),
              const SizedBox(height: AppSize.emptySizeLow),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: AppSize.one,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.radius),
                ),
                child: Column(
                  children: <Widget>[
                    Obx(
                      controller.materialItemCount,
                      builder: (BuildContext context, Rx<int> materialItemCount, Widget? child) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryBackground,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.radius),
                              topRight: Radius.circular(AppSize.radius),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: AppSize.paddingNormal,
                              right: AppSize.paddingNormal,
                              top: AppSize.paddingHigh,
                              //bottom: AppSize.paddingHigh,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    controller.calculationCustomModel != null ? 'Custom block' : controller.selectedMaterialModel?.name ?? '',
                                    softWrap: true,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    materialItemCount.value.toString(),
                                    textAlign: TextAlign.right,
                                    softWrap: true,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: switch (controller.selectedMaterialModel?.price == null) {
                                    true => Text(
                                      '${controller.priceOneBlock}₮',
                                      textAlign: TextAlign.right,
                                      softWrap: true,
                                    ),
                                    false => Text(
                                      '${controller.selectedMaterialModel?.price}₮',
                                      textAlign: TextAlign.right,
                                      softWrap: true,
                                    ),
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    Obx(
                      controller.ingCalcModelList,
                      builder: (BuildContext context, Rx<List<IngCalcModel>> ingCalcModelList, Widget? child) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryBackground,
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(AppSize.radius),
                            //   topRight: Radius.circular(AppSize.radius),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: AppSize.paddingNormal,
                              right: AppSize.paddingNormal,
                            ),
                            child: Column(
                              children: ingCalcModelList.value.map((IngCalcModel ingredient) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: AppSize.padding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          ingredient.name,
                                          softWrap: true,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${ingredient.amount.toStringAsFixed(2)} ${ingredient.unit}',
                                          textAlign: TextAlign.right,
                                          softWrap: true,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${ingredient.price.toStringAsFixed(2)} ₮',
                                          textAlign: TextAlign.right,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),

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
                              TextConstants.total,
                              style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                            ),
                            Obx(
                              controller.totalPrice,
                              builder: (BuildContext context, Rx<double> totalPrice, Widget? child) {
                                return Text(
                                  '${totalPrice.value.toStringAsFixed(3)} ₮',
                                  style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSize.emptySize),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppButton.secondarySmall(
                    text: TextConstants.back,
                    onTap: () => AppNavigation.popRoute(context),
                  ),
                  AppButton.primarySmall(
                    text: TextConstants.save,
                    onTap: () => controller.onSave(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
        Text(
          title,
          style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
        ),

        Text(
          size,
          style: AppTextStyles.bodyMedium(color: AppColors.inverseSurface),
        ),

        Text(
          price,
          style: AppTextStyles.bodyMedium(color: AppColors.inverseSurface),
        ),
      ],
    );
  }
}
