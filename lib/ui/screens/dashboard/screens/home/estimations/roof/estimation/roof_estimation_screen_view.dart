import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../../../core/utils/validation/form_validation.dart';
import '../../../../../../../components/widgets/choose_material_item.dart';
import '../../../../../../../components/widgets/choose_shape_item.dart';
import '../../../../../../../components/widgets/choose_type_button.dart';
import '../../../../../../../components/widgets/choose_type_item.dart';
import '../../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../../components/widgets/custom_calculation_button.dart';
import '../../../../../../../components/widgets/obx.dart';
import '../../../../../../../components/widgets/textfields/custom_size_entry_text_field.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_view.dart';
import '../../../model/choose_material_model.dart';
import '../../../model/choose_shape_model.dart';
import '../../../model/choose_type_model.dart';
import 'roof_estimation_screen_controller.dart';

const Color _dropdownColor = Color(0xFF634AFD);

const String _estimationType = 'roof';
const String _estimationMaterialType = 'Roof';

@RoutePage()
final class RoofEstimationScreenView extends BaseScreenView<RoofEstimationScreenController, DefaultScreenArgs> {
  const RoofEstimationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<RoofEstimationScreenView> createState() => _RoofEstimationScreenViewState();
}

final class _RoofEstimationScreenViewState extends BaseScreenViewState<RoofEstimationScreenView, RoofEstimationScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, RoofEstimationScreenController controller) {
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
                    TextConstants.roofEstimation,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: AppSize.emptySizeLow),

            Expanded(
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSize.paddingZero),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        TextConstants.roofDimension,
                        style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                      ),

                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.roofLengthController,
                        hintText: TextConstants.enterFloorLength,
                        sizeTitle: TextConstants.length,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorRoofLength),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.roofWidthController,
                        hintText: TextConstants.enterFloorWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorRoofWidth),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      Text(TextConstants.type, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                      const SizedBox(height: AppSize.emptySize),

                      Obx(
                        controller.selectedTypeModel,
                        builder: (BuildContext context, Rxn<ChooseType> selectedTypeModel, Widget? child) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ChooseTypeButton(
                                  chooseTypeModel: ChooseTypeModel(
                                    type: _estimationType,
                                    onItemTap: (ChooseType selectedChooseTypeModel) => <void>{
                                      selectedTypeModel.value = selectedChooseTypeModel,
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.emptySizeLowest),
                              Expanded(
                                child: switch (selectedTypeModel.value == null) {
                                  true => const ImageTypeShow(),
                                  false => ChooseTypeItem(
                                    chooseType: selectedTypeModel.value,
                                  ),
                                },
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: AppSize.emptySize),

                      Text(TextConstants.material, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                      const SizedBox(height: AppSize.emptySize),

                      Obx(
                        controller.selectedMaterialModel,
                        builder: (BuildContext context, Rxn<MaterialItem> selectedMaterialModel, Widget? child) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ChooseTypeButton(
                                  chooseMaterialModel: ChooseMaterialModel(
                                    type: _estimationMaterialType,
                                    onItemTap: (MaterialItem selectedChooseMaterialModel) => <void>{
                                      selectedMaterialModel.value = selectedChooseMaterialModel,
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.emptySizeLowest),
                              Expanded(
                                child: switch (selectedMaterialModel.value == null) {
                                  true => const ImageTypeShow(),
                                  false => ChooseMaterialItem(
                                    materialItem: selectedMaterialModel.value,
                                  ),
                                },
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: AppSize.emptySize),

                      Text(TextConstants.roofFloor, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                      const SizedBox(height: AppSize.emptySize),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.padding,
                          vertical: !context.isSmallScreen ? AppSize.paddingLowest : AppSize.paddingZero,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: AppSize.one,
                          ),
                          borderRadius: BorderRadius.circular(AppSize.radius),
                        ),
                        child: Obx(
                          controller.selectedShape,
                          builder: (BuildContext context, Rxn<bool> value, Widget? child) {
                            return DropdownButton<bool>(
                              value: controller.selectedShape.value,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: _dropdownColor,
                              ),
                              hint: Center(
                                child: Text(
                                  TextConstants.chooseIncludeRoofFloorOrNot,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.labelSmall(
                                    fontFamily: fontFamilyRaleway,
                                    color: AppColors.onSecondary,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              underline: const SizedBox(),
                              dropdownColor: AppColors.onPrimary,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(AppSize.radius),
                              items: const <DropdownMenuItem<bool>>[
                                DropdownMenuItem<bool>(
                                  value: true,
                                  child: Center(child: Text(TextConstants.yes)),
                                ),
                                DropdownMenuItem<bool>(
                                  value: false,
                                  child: Center(child: Text(TextConstants.no)),
                                ),
                              ],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  controller.changeRoofShape(value);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSize.emptySize),

                      Obx(
                        controller.selectedShape,
                        builder: (BuildContext context, Rxn<bool> value, Widget? child) {
                          return AnimatedOpacity(
                            opacity: controller.selectedShape.value ?? false ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: AppSize.durationMedium),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: AppSize.durationMedium),
                              height: controller.selectedShape.value ?? false ? null : 0,
                              child: controller.selectedShape.value ?? false
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(TextConstants.chooseShape, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                                        const SizedBox(height: AppSize.emptySize),

                                        Obx(
                                          controller.selectedShapeModel,
                                          builder: (BuildContext context, Rxn<ChooseShape> selectedShapeModel, Widget? child) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: ChooseTypeButton(
                                                    chooseShapeModel: ChooseShapeModel(
                                                      onItemTap: (ChooseShape selectedChooseShapeModel) => <void>{
                                                        selectedShapeModel.value = selectedChooseShapeModel,
                                                      },
                                                    ),
                                                    isLeftAlignText: true,
                                                  ),
                                                ),
                                                const SizedBox(width: AppSize.emptySizeLowest),
                                                Expanded(
                                                  child: AnimatedSwitcher(
                                                    duration: const Duration(milliseconds: 200),
                                                    child: selectedShapeModel.value == null
                                                        ? const ImageTypeShow(key: ValueKey<String>('empty'))
                                                        : ChooseShapeItem(
                                                            key: const ValueKey<String>('selected'),
                                                            chooseShape: selectedShapeModel.value,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(height: AppSize.emptySize),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomCalculationButton(
                            onTap: controller.onCalculatePressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
