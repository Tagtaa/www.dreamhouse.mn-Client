import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/calculation/door_window_model.dart';
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
import '../../../widget/add_doow_window_view.dart';
import '../../../widget/estimation_add_buttons.dart';
import 'wall_decoration_estimation_screen_controller.dart';

const String _estimationType = 'wall_decoration';
const String _estimationMaterialType = 'Wall decoration';

@RoutePage()
final class WallDecorationEstimationScreenView extends BaseScreenView<WallDecorationEstimationScreenController, DefaultScreenArgs> {
  const WallDecorationEstimationScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: false),
      );

  @override
  State<WallDecorationEstimationScreenView> createState() => _WallDecorationEstimationScreenViewState();
}

final class _WallDecorationEstimationScreenViewState extends BaseScreenViewState<WallDecorationEstimationScreenView, WallDecorationEstimationScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, WallDecorationEstimationScreenController controller) {
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
                    TextConstants.wallPaperEstimation,
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
                                    onItemTap: (ChooseType selectedChooseTypeModel) {
                                      selectedTypeModel.value = selectedChooseTypeModel;
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
                                child: switch (controller.selectedMaterialModel.value == null) {
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
