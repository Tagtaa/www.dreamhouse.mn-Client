import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/models/calculation/calculation_custom_model.dart';
import '../../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../../components/snackbar/custom_snackbar.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_controller.dart';
import '../../calculation/calculation_screen_args.dart';

final class FloorTilesEstimationScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  FloorTilesEstimationScreenController(
    super.args,
    this._calculationService,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController floorLengthController = TextEditingController();
  final TextEditingController floorWidthController = TextEditingController();
  final TextEditingController blockLengthController = TextEditingController();
  final TextEditingController blockWidthController = TextEditingController();
  final TextEditingController blockHeightController = TextEditingController();
  final TextEditingController enterPriceOnePieceController = TextEditingController();

  Rxn<ChooseType> selectedTypeModel = Rxn<ChooseType>();
  Rxn<MaterialItem> selectedMaterialModel = Rxn<MaterialItem>();
  Rxn<ChooseThickness> selectedThicknessModel = Rxn<ChooseThickness>();
  Rxn<CalculationCustomModel> calculationCustomModel = Rxn<CalculationCustomModel>();

  double? totalArea;
  int? materialItemCount;

  @override
  void onDispose() {
    floorLengthController.dispose();
    floorWidthController.dispose();
    blockLengthController.dispose();
    blockWidthController.dispose();
    blockHeightController.dispose();
    enterPriceOnePieceController.dispose();
    super.onDispose();
  }

  void onCalculatePressed() {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      debugPrint('Form valid');

      if (selectedTypeModel.value == null || selectedTypeModel.value?.key != TextConstants.customType && (selectedMaterialModel.value == null)) {
        if (context() != null) {
          CustomSnackBar.show(context: context()!, message: TextConstants.selectRequiredItem);
        }
      } else {
        _calculateVolume();
        if (totalArea != null) {
          AppNavigation.gotoCalculationRoute(
            context(),
            args: CalculationScreenArgs(
              area: totalArea!,
              selectedMaterialModel: selectedMaterialModel.value,
              selectedThicknessModel: selectedThicknessModel.value,
              selectedTypeModel: selectedTypeModel.value,
              materialItemCount: materialItemCount,
              priceOneBlock: double.tryParse(enterPriceOnePieceController.text),
              calculationCustomModel: calculationCustomModel.value,
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
    final double L = _cmToM(floorLengthController.text);
    final double W = _cmToM(floorWidthController.text);

    late final double materialWidth;
    late final double materialHeight;
    late final double materialLength;

    if (selectedTypeModel.value?.key == TextConstants.customType) {
      materialWidth = _cmToM3(double.tryParse(blockWidthController.text) ?? 1.0);
      materialLength = _cmToM3(double.tryParse(blockLengthController.text) ?? 1.0);
      materialHeight = _cmToM3(double.tryParse(blockHeightController.text) ?? 1.0);

      calculationCustomModel(
        set: () => CalculationCustomModel(
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
      materialWidth = _cmToM3(selectedMaterialModel.value?.width?.toDouble() ?? 1.0);
      materialLength = _cmToM3(selectedMaterialModel.value?.length?.toDouble() ?? 1.0);
      materialHeight = _cmToM3(selectedMaterialModel.value?.height?.toDouble() ?? 1.0);
    }

    totalArea = L * W;

    final double materialVolume = materialWidth * materialLength * materialHeight;
    final double needMaterial = totalArea! / materialVolume;
    materialItemCount = needMaterial.ceil();

    debugPrint('Net wall volume: $totalArea m³');
    debugPrint('Net materialVolume volume: $materialVolume m³');
    debugPrint('Net needMaterial count: $needMaterial m³');
  }
}
