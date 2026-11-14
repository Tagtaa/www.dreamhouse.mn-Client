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
import 'fundament_estimation_screen_controller.dart';

const String _estimationType = 'fundament';
const String _estimationMaterialType = 'Fundament';

@RoutePage()
final class FundamentEstimationScreenView extends BaseScreenView<FundamentEstimationScreenController, DefaultScreenArgs> {
  const FundamentEstimationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<FundamentEstimationScreenView> createState() => _FundamentEstimationScreenViewState();
}

final class _FundamentEstimationScreenViewState extends BaseScreenViewState<FundamentEstimationScreenView, FundamentEstimationScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, FundamentEstimationScreenController controller) {
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
                    TextConstants.fundamentEstimation,
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
                        TextConstants.fundamentDimension,
                        style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                      ),

                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.fundamentLengthController,
                        hintText: TextConstants.enterFundamentLength,
                        sizeTitle: TextConstants.length,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorFundamentLength),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.fundamentWidthController,
                        hintText: TextConstants.enterFundamentWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorFundamentWidth),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.fundamentHeightController,
                        hintText: TextConstants.enterFundamentHeight,
                        sizeTitle: TextConstants.height,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorFundamentHeight),
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
