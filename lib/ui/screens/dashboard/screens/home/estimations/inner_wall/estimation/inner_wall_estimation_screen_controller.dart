import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../../core/models/calculation/calculation_custom_model.dart';
import '../../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_controller.dart';
import '../../calculation/calculation_screen_args.dart';

final class InnerWallEstimationScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  InnerWallEstimationScreenController(
    super.args,
    this._calculationService,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController innerWallWidthController = TextEditingController();
  final TextEditingController innerWallLengthController = TextEditingController();
  final TextEditingController blockLengthController = TextEditingController();
  final TextEditingController blockWidthController = TextEditingController();
  final TextEditingController blockHeightController = TextEditingController();
  final TextEditingController enterPriceOnePieceController = TextEditingController();
  final TextEditingController wallThicknessPieceController = TextEditingController();

  Rxn<ChooseType> selectedTypeModel = Rxn<ChooseType>();
  Rxn<MaterialItem> selectedMaterialModel = Rxn<MaterialItem>();
  Rxn<ChooseThickness> selectedThicknessModel = Rxn<ChooseThickness>();
  Rxn<CalculationCustomModel> calculationCustomModel = Rxn<CalculationCustomModel>();

  double? totalArea;
  int? materialItemCount;

  @override
  void onDispose() {
    innerWallLengthController.dispose();
    innerWallWidthController.dispose();
    blockLengthController.dispose();
    blockWidthController.dispose();
    blockHeightController.dispose();
    enterPriceOnePieceController.dispose();
    wallThicknessPieceController.dispose();
    super.onDispose();
  }

  void onCalculatePressed() {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      debugPrint('Form valid');

      if (selectedTypeModel.value == null ||
          selectedTypeModel.value?.key != TextConstants.customType &&
              (selectedMaterialModel.value == null || (selectedThicknessModel.value == null && selectedTypeModel.value?.key == TextConstants.customType))) {
        if (context() != null) {
          ScaffoldMessenger.of(context()!).showSnackBar(
            const SnackBar(
              content: Text(TextConstants.selectRequiredItem),
              duration: Duration(seconds: 2),
              backgroundColor: AppColors.background,
            ),
          );
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
    final double W = _cmToM(innerWallWidthController.text);
    final double L = _cmToM(innerWallLengthController.text);

    late final double materialWidth;
    late final double materialHeight;
    late final double materialLength;
    late final double thicknessM;

    if (selectedTypeModel.value?.key == TextConstants.customType) {
      thicknessM = (double.tryParse(wallThicknessPieceController.text) ?? 1.0) / 100.0;
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
      materialWidth = _cmToM3(selectedMaterialModel.value?.width?.toDouble() ?? 1.0);
      materialHeight = _cmToM3(selectedMaterialModel.value?.height?.toDouble() ?? 1.0);
    }

    totalArea = 2 * (L + W);

    final double materialArea = materialWidth * materialHeight;
    final double needMaterial = totalArea! / materialArea;
    materialItemCount = needMaterial.ceil();

    debugPrint('Net wall volume: $totalArea m³');
    debugPrint('Net materialVolume volume: $materialArea m³');
    debugPrint('Net needMaterial count: $needMaterial m³');
  }
}
