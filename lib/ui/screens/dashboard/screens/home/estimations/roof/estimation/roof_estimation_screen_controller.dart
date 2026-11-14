import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../../core/models/rx.dart';
import '../../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../../components/snackbar/custom_snackbar.dart';
import '../../../../../../base_screen_args.dart';
import '../../../../../../base_screen_controller.dart';
import '../../calculation/calculation_screen_args.dart';

final class RoofEstimationScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  RoofEstimationScreenController(
    super.args,
    this._calculationService,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();
  Rxn<bool> selectedShape = Rxn<bool>();

  final TextEditingController roofLengthController = TextEditingController();
  final TextEditingController roofWidthController = TextEditingController();

  Rxn<ChooseType> selectedTypeModel = Rxn<ChooseType>();
  Rxn<MaterialItem> selectedMaterialModel = Rxn<MaterialItem>();
  Rxn<ChooseShape> selectedShapeModel = Rxn<ChooseShape>();

  double? totalArea;
  int? materialItemCount;

  @override
  void onDispose() {
    roofLengthController.dispose();
    roofWidthController.dispose();
    super.onDispose();
  }

  void onCalculatePressed() {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      debugPrint('Form valid');

      if (selectedTypeModel.value == null || (selectedTypeModel.value?.key != TextConstants.customType && selectedMaterialModel.value == null)) {
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
              selectedTypeModel: selectedTypeModel.value,
              selectedShapeModel: selectedShapeModel.value,
              materialItemCount: materialItemCount,
            ),
          );
        }
      }
    } else {
      debugPrint('Form invalid!');
    }
  }

  Future<void> changeRoofShape(bool shape) async {
    selectedShape(set: () => shape);

    if (shape) {
      await Future<void>.delayed(const Duration(milliseconds: 350), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  double _cmToM(String text) => (double.tryParse(text) ?? 0) / 100.0;

  double _cmToM3(double value) => value / 100.0;

  void _calculateVolume() {
    final double L = _cmToM(roofLengthController.text);
    final double W = _cmToM(roofWidthController.text);

    totalArea = L * W;

    final double materialWidth = _cmToM3(selectedMaterialModel.value?.width?.toDouble() ?? 1.0);
    final double materialLength = _cmToM3(selectedMaterialModel.value?.length?.toDouble() ?? 1.0);

    final double materialArea = materialWidth * materialLength;
    final double needMaterial = totalArea! / materialArea;
    materialItemCount = needMaterial.ceil();

    debugPrint('Net roof area: $totalArea m³');
    debugPrint('Net needMaterial count: $needMaterial m³');
  }
}
