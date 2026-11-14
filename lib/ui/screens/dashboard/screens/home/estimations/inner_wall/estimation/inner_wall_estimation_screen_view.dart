import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/utils/validation/form_validation.dart';
import '../../../../../../../components/widgets/choose_material_item.dart';
import '../../../../../../../components/widgets/choose_type_button.dart';
import '../../../../../../../components/widgets/choose_type_item.dart';
import '../../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../../components/widgets/custom_calculation_button.dart';
import '../../../../../../../components/widgets/obx.dart';
import '../../../../../../../components/widgets/textfields/custom_size_entry_text_field.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_view.dart';
import '../../../model/choose_material_model.dart';
import '../../../model/choose_type_model.dart';
import 'inner_wall_estimation_screen_controller.dart';

const String _estimationType = 'inner_wall';
const String _estimationMaterialType = 'Inner Wall';

@RoutePage()
final class InnerWallEstimationScreenView extends BaseScreenView<InnerWallEstimationScreenController, DefaultScreenArgs> {
  const InnerWallEstimationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<InnerWallEstimationScreenView> createState() => _InnerWallEstimationScreenViewState();
}

final class _InnerWallEstimationScreenViewState extends BaseScreenViewState<InnerWallEstimationScreenView, InnerWallEstimationScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, InnerWallEstimationScreenController controller) {
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
                    TextConstants.innerWallEstimation,
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
                        TextConstants.innerWallDimension,
                        style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                      ),

                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.innerWallLengthController,
                        hintText: TextConstants.enterWallLength,
                        sizeTitle: TextConstants.height,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorInnerWallHeight),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.innerWallWidthController,
                        hintText: TextConstants.enterWallWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorInnerWallWidth),
                      ),

                      const SizedBox(height: AppSize.emptySize),

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
                        controller.selectedTypeModel,
                        builder: (BuildContext context, Rxn<ChooseType> selectedTypeModel, Widget? child) {
                          return switch (selectedTypeModel.value?.key == TextConstants.customType) {
                            true => Column(
                              children: <Widget>[
                                CustomSizeEntryTextField(
                                  controller: controller.blockLengthController,
                                  hintText: TextConstants.enterRoomLength,
                                  sizeTitle: TextConstants.length,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorBlockLength),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                CustomSizeEntryTextField(
                                  controller: controller.blockWidthController,
                                  hintText: TextConstants.enterRoomWidth,
                                  sizeTitle: TextConstants.width,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorBlockWidth),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                CustomSizeEntryTextField(
                                  controller: controller.blockHeightController,
                                  hintText: TextConstants.enterRoomHeight,
                                  sizeTitle: TextConstants.height,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorBlockHeight),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                CustomSizeEntryTextField(
                                  controller: controller.enterPriceOnePieceController,
                                  hintText: TextConstants.enterPriceOfOnePiece,
                                  sizeTitle: TextConstants.blockPriceTitle,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorPriceOfOnePiece),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                Text(
                                  TextConstants.wallThickness,
                                  style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                                ),

                                const SizedBox(height: AppSize.emptySize),

                                CustomSizeEntryTextField(
                                  controller: controller.wallThicknessPieceController,
                                  hintText: TextConstants.enterWallThickness,
                                  sizeTitle: TextConstants.thickness,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorWallThickness),
                                ),
                              ],
                            ),
                            false => Obx(
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
                          };
                        },
                      ),

                      const SizedBox(height: AppSize.emptySize),

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
