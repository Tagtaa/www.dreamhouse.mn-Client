import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/models/calculation/calculation_custom_model.dart';
import '../../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/calculation/door_window_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../../components/snackbar/custom_snackbar.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_controller.dart';
import '../../calculation/calculation_screen_args.dart';

final class WallEstimationScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  WallEstimationScreenController(
    super.args,
    this._calculationService,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController roomLengthController = TextEditingController();
  final TextEditingController roomWidthController = TextEditingController();
  final TextEditingController roomHeightController = TextEditingController();
  final TextEditingController windowHeightController = TextEditingController();
  final TextEditingController windowWidthController = TextEditingController();
  final TextEditingController doorHeightController = TextEditingController();
  final TextEditingController doorWidthController = TextEditingController();
  final TextEditingController blockLengthController = TextEditingController();
  final TextEditingController blockWidthController = TextEditingController();
  final TextEditingController blockHeightController = TextEditingController();
  final TextEditingController enterPriceOnePieceController = TextEditingController();
  final TextEditingController wallThicknessPieceController = TextEditingController();

  Rxn<ChooseType> selectedTypeModel = Rxn<ChooseType>();
  Rxn<MaterialItem> selectedMaterialModel = Rxn<MaterialItem>();
  Rxn<ChooseThickness> selectedThicknessModel = Rxn<ChooseThickness>();
  Rxn<CalculationCustomModel> calculationCustomModel = Rxn<CalculationCustomModel>();

  double? totalVolume;
  int? materialItemCount;

  Rx<List<DoorWindowModel>> doorList = Rx<List<DoorWindowModel>>(<DoorWindowModel>[]);
  Rx<List<DoorWindowModel>> windowList = Rx<List<DoorWindowModel>>(<DoorWindowModel>[]);

  @override
  void onDispose() {
    roomLengthController.dispose();
    roomWidthController.dispose();
    roomHeightController.dispose();
    windowHeightController.dispose();
    windowWidthController.dispose();
    doorHeightController.dispose();
    doorWidthController.dispose();
    blockLengthController.dispose();
    blockWidthController.dispose();
    blockHeightController.dispose();
    enterPriceOnePieceController.dispose();
    wallThicknessPieceController.dispose();

    super.onDispose();
  }

  void removeDoorTap(int index) {
    doorList.value.removeAt(index);
    doorList.refresh();
  }

  void removeWindowTap(int index) {
    windowList.value.removeAt(index);
    windowList.refresh();
  }

  void onAddDoorTap() {
    if (doorWidthController.text.isEmpty || double.tryParse(doorWidthController.text) == null) {
      return;
    }

    if (doorHeightController.text.isEmpty || double.tryParse(doorHeightController.text) == null) {
      return;
    }
    final DoorWindowModel door = DoorWindowModel(width: double.parse(doorWidthController.text), height: double.parse(doorHeightController.text));
    doorList.value.add(door);
    doorList.refresh();
    doorWidthController.clear();
    doorHeightController.clear();
  }

  void onAddWindowTap() {
    if (windowWidthController.text.isEmpty || double.tryParse(windowWidthController.text) == null) {
      return;
    }

    if (windowHeightController.text.isEmpty || double.tryParse(windowHeightController.text) == null) {
      return;
    }

    final DoorWindowModel window = DoorWindowModel(width: double.parse(windowWidthController.text), height: double.parse(windowHeightController.text));
    windowList.value.add(window);
    windowList.refresh();
    windowWidthController.clear();
    windowHeightController.clear();
  }

  void onCalculatePressed() {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      debugPrint('Form valid');

      if (selectedTypeModel.value == null || (selectedTypeModel.value?.key != TextConstants.customType && (selectedMaterialModel.value == null || selectedThicknessModel.value == null))) {
        if (context() != null) {
          CustomSnackBar.show(context: context()!, message: TextConstants.selectRequiredItem);
        }
      } else {
        _calculateVolume();
        if (totalVolume != null) {
          AppNavigation.gotoCalculationRoute(
            context(),
            args: CalculationScreenArgs(
              volume: totalVolume!,
              doorList: doorList.value,
              windowList: windowList.value,
              selectedMaterialModel: selectedMaterialModel.value,
              selectedThicknessModel: selectedThicknessModel.value,
              selectedTypeModel: selectedTypeModel.value,
              materialItemCount: materialItemCount,
              calculationCustomModel: calculationCustomModel.value,
              priceOneBlock: double.tryParse(enterPriceOnePieceController.text),
            ),
          );
        }
      }
    } else {
      debugPrint('Form invalid!');
    }
  }

  double _cmToM(String text) => (double.tryParse(text) ?? 0) / 100.0;

  double _cmToM3(double value) => value / 100.0;

  void _calculateVolume() {
    final double L = _cmToM(roomLengthController.text);
    final double W = _cmToM(roomWidthController.text);
    final double H = _cmToM(roomHeightController.text);

    final double winH = _cmToM(windowHeightController.text);
    final double winW = _cmToM(windowWidthController.text);
    final double doorL = _cmToM(doorHeightController.text);
    final double doorW = _cmToM(doorWidthController.text);

    windowList.value.add(DoorWindowModel(width: double.tryParse(windowWidthController.text) ?? 0, height: double.tryParse(windowHeightController.text) ?? 0));

    doorList.value.add(DoorWindowModel(width: double.tryParse(doorWidthController.text) ?? 0, height: double.tryParse(doorHeightController.text) ?? 0));

    late final double thicknessM;
    late final double materialWidth;
    late final double materialLength;
    late final double materialHeight;

    if (selectedTypeModel.value?.key == TextConstants.customType) {
      thicknessM = double.tryParse(wallThicknessPieceController.text) ?? 1.0 / 100.0;
      materialWidth = _cmToM3(double.tryParse(blockWidthController.text) ?? 1.0);
      materialLength = _cmToM3(double.tryParse(blockLengthController.text) ?? 1.0);
      materialHeight = _cmToM3(double.tryParse(blockHeightController.text) ?? 1.0);

      calculationCustomModel(
        set: () => CalculationCustomModel(
          blockThickness: thicknessM,
          blockHeight: materialHeight,
          blockLength: materialLength,
          blockWidth: materialWidth,
          price: double.tryParse(enterPriceOnePieceController.text),
          imageUrl: selectedTypeModel.value?.imageUrl,
        ),
      );

      selectedMaterialModel(set: () => null);
      selectedThicknessModel(set: () => null);
    } else {
      thicknessM = (selectedThicknessModel.value?.thickness?.toDouble() ?? 1) / 100.0;
      materialWidth = _cmToM3(selectedMaterialModel.value?.width?.toDouble() ?? 1.0);
      materialLength = _cmToM3(selectedMaterialModel.value?.length?.toDouble() ?? 1.0);
      materialHeight = _cmToM3(selectedMaterialModel.value?.height?.toDouble() ?? 1.0);
    }

    final double totalWallArea = 2 * (L + W) * H;
    final double openingsArea = (winH * winW) + (doorL * doorW);
    final double netWallArea = (totalWallArea - openingsArea).clamp(0, double.infinity);
    final double wallVolumeM3 = netWallArea * thicknessM;
    totalVolume = wallVolumeM3;

    final double materialVolume = materialWidth * materialLength * materialHeight;
    final double needMaterial = wallVolumeM3 / materialVolume;
    materialItemCount = needMaterial.ceil();

    debugPrint('Net wall volume: $wallVolumeM3 m³');
    debugPrint('Net materialVolume volume: $materialVolume m³');
    debugPrint('Net needMaterial count: $needMaterial m³');
  }
}
