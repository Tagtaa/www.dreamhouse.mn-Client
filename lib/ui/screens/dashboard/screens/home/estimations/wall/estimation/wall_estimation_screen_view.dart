import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/calculation/door_window_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/utils/validation/form_validation.dart';
import '../../../../../../../components/widgets/choose_material_item.dart';
import '../../../../../../../components/widgets/choose_thickness_item.dart';
import '../../../../../../../components/widgets/choose_type_button.dart';
import '../../../../../../../components/widgets/choose_type_item.dart';
import '../../../../../../../components/widgets/custom_back_button.dart';
import '../../../../../../../components/widgets/custom_calculation_button.dart';
import '../../../../../../../components/widgets/obx.dart';
import '../../../../../../../components/widgets/textfields/custom_size_entry_text_field.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_view.dart';
import '../../../model/choose_material_model.dart';
import '../../../model/choose_thickness_model.dart';
import '../../../model/choose_type_model.dart';
import '../../../widget/add_doow_window_view.dart';
import '../../../widget/estimation_add_buttons.dart';
import 'wall_estimation_screen_controller.dart';

const String _estimationType = 'wall';
const String _estimationMaterialType = 'Wall';

@RoutePage()
final class WallEstimationScreenView extends BaseScreenView<WallEstimationScreenController, DefaultScreenArgs> {
  const WallEstimationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<WallEstimationScreenView> createState() => _WallEstimationScreenViewState();
}

final class _WallEstimationScreenViewState extends BaseScreenViewState<WallEstimationScreenView, WallEstimationScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, WallEstimationScreenController controller) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
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
                    TextConstants.wallEstimation,
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
                        TextConstants.roomDimension,
                        style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                      ),

                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.roomLengthController,
                        hintText: TextConstants.enterRoomLength,
                        sizeTitle: TextConstants.length,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorRoomLength),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.roomWidthController,
                        hintText: TextConstants.enterRoomWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorRoomWidth),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.roomHeightController,
                        hintText: TextConstants.enterRoomHeight,
                        sizeTitle: TextConstants.height,
                        validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorRoomHeight),
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      Text(TextConstants.windowSize, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                      const SizedBox(height: AppSize.emptySize),

                      CustomSizeEntryTextField(
                        controller: controller.windowHeightController,
                        hintText: TextConstants.enterWindowHeight,
                        sizeTitle: TextConstants.height,
                        validator: (String? value) {
                          if (controller.windowList.value.isNotEmpty) {
                            return null;
                          }
                          return FormValidators.validateNumber(value, fieldName: TextConstants.validatorWindowHeight);
                        },
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      CustomSizeEntryTextField(
                        controller: controller.windowWidthController,
                        hintText: TextConstants.enterWindowWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) {
                          if (controller.windowList.value.isNotEmpty) {
                            return null;
                          }
                          if (value != null && ((double.tryParse(value) ?? 0.0) > (double.tryParse(controller.roomWidthController.text) ?? 0.0))) {
                            return TextConstants.doorWindowWidthErrorOnDoorWidth;
                          }
                          return FormValidators.validateNumber(value, fieldName: TextConstants.validatorWindowWidth);
                        },
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),

                      Obx(
                        controller.windowList,
                        builder: (BuildContext context, Rx<List<DoorWindowModel>> windowList, Widget? child) {
                          return switch (windowList.value.isEmpty) {
                            true => const SizedBox(),
                            false => Obx(
                              controller.windowList,
                              builder: (BuildContext context, Rx<List<DoorWindowModel>> windowList, _) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: windowList.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final DoorWindowModel item = windowList.value[index];
                                    return DoorWindowItemView(
                                      index: index,
                                      item: item,
                                      isWindow: true,
                                      onDelete: () => controller.removeWindowTap(index),
                                    );
                                  },
                                );
                              },
                            ),
                          };
                        },
                      ),

                      EstimationAddButtons(
                        text: TextConstants.addWindow,
                        onTap: controller.onAddWindowTap,
                      ),

                      const SizedBox(height: AppSize.emptySize),

                      Text(TextConstants.doorSize, style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize)),
                      const SizedBox(height: AppSize.emptySize),

                      CustomSizeEntryTextField(
                        controller: controller.doorHeightController,
                        hintText: TextConstants.enterDoorHeight,
                        sizeTitle: TextConstants.height,
                        validator: (String? value) {
                          if (controller.doorList.value.isNotEmpty) {
                            return null;
                          }
                          return FormValidators.validateNumber(value, fieldName: TextConstants.validatorDoorLength);
                        },
                      ),
                      const SizedBox(height: AppSize.emptySizeLow),
                      CustomSizeEntryTextField(
                        controller: controller.doorWidthController,
                        hintText: TextConstants.enterDoorWidth,
                        sizeTitle: TextConstants.width,
                        validator: (String? value) {
                          if (controller.doorList.value.isNotEmpty) {
                            return null;
                          }
                          if (value != null && ((double.tryParse(value) ?? 0.0) > (double.tryParse(controller.roomWidthController.text) ?? 0.0))) {
                            return TextConstants.doorWindowWidthErrorOnDoorWidth;
                          }
                          return FormValidators.validateNumber(value, fieldName: TextConstants.validatorDoorWidth);
                        },
                      ),

                      const SizedBox(height: AppSize.emptySizeLow),

                      Obx(
                        controller.doorList,
                        builder: (BuildContext context, Rx<List<DoorWindowModel>> doorList, Widget? child) {
                          return switch (doorList.value.isEmpty) {
                            true => const SizedBox(),
                            false => Obx(
                              controller.doorList,
                              builder: (BuildContext context, Rx<List<DoorWindowModel>> doorList, _) {
                                if (doorList.value.isEmpty) {
                                  return const SizedBox();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: doorList.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final DoorWindowModel item = doorList.value[index];
                                    return DoorWindowItemView(
                                      index: index,
                                      item: item,
                                      isWindow: false,
                                      onDelete: () => controller.removeDoorTap(index),
                                    );
                                  },
                                );
                              },
                            ),
                          };
                        },
                      ),

                      EstimationAddButtons(
                        text: TextConstants.addDoor,
                        width: AppSize.estimationAddDoorButtonWidth,
                        onTap: controller.onAddDoorTap,
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
                                  hintText: TextConstants.enterBlockLength,
                                  sizeTitle: TextConstants.length,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorBlockLength),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                CustomSizeEntryTextField(
                                  controller: controller.blockWidthController,
                                  hintText: TextConstants.enterBlockWidth,
                                  sizeTitle: TextConstants.width,
                                  validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorBlockWidth),
                                ),
                                const SizedBox(height: AppSize.emptySizeLow),

                                CustomSizeEntryTextField(
                                  controller: controller.blockHeightController,
                                  hintText: TextConstants.enterBlockHeight,
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
                              ],
                            ),
                            false => Obx(
                              controller.selectedMaterialModel,
                              builder: (BuildContext context, Rxn<MaterialItem> selectedMaterialModel, Widget? child) {
                                return Row(
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

                      Text(
                        TextConstants.wallThickness,
                        style: AppTextStyles.labelMedium(fontSize: AppSize.headlineFontSize),
                      ),
                      const SizedBox(height: AppSize.emptySize),

                      Obx(
                        controller.selectedTypeModel,
                        builder: (BuildContext context, Rxn<ChooseType> selectedTypeModel, Widget? child) {
                          return switch (selectedTypeModel.value?.key == TextConstants.customType) {
                            true => CustomSizeEntryTextField(
                              controller: controller.wallThicknessPieceController,
                              hintText: TextConstants.enterWallThickness,
                              sizeTitle: TextConstants.thickness,
                              validator: (String? value) => FormValidators.validateNumber(value, fieldName: TextConstants.validatorWallThickness),
                            ),
                            false => Obx(
                              controller.selectedThicknessModel,
                              builder: (BuildContext context, Rxn<ChooseThickness> selectedThicknessModel, Widget? child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: ChooseTypeButton(
                                        chooseThicknessModel: ChooseThicknessModel(
                                          onItemTap: (ChooseThickness selectedChooseThicknessModel) => <void>{
                                            selectedThicknessModel.value = selectedChooseThicknessModel,
                                          },
                                        ),
                                        isLeftAlignText: true,
                                      ),
                                    ),

                                    const SizedBox(width: AppSize.emptySizeLowest),
                                    Expanded(
                                      child: switch (selectedThicknessModel.value == null) {
                                        true => const ImageTypeShow(),
                                        false => ChooseThicknessItem(
                                          chooseThickness: selectedThicknessModel.value,
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
