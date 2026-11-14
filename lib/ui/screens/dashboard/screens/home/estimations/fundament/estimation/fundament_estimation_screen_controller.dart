import 'package:flutter/material.dart';

import '../../../../../../../../core/configs/constants/text_constants.dart';
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

final class FundamentEstimationScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;

  FundamentEstimationScreenController(super.args, this._calculationService);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fundamentLengthController = TextEditingController();
  final TextEditingController fundamentWidthController = TextEditingController();
  final TextEditingController fundamentHeightController = TextEditingController();

  Rxn<ChooseType> selectedTypeModel = Rxn<ChooseType>();
  Rxn<MaterialItem> selectedMaterialModel = Rxn<MaterialItem>();
  Rxn<ChooseThickness> selectedThicknessModel = Rxn<ChooseThickness>();

  double? totalVolumeM3;

  @override
  void onDispose() {
    fundamentLengthController.dispose();
    fundamentWidthController.dispose();
    fundamentHeightController.dispose();
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
        if (totalVolumeM3 != null) {
          AppNavigation.gotoCalculationRoute(
            context(),
            args: CalculationScreenArgs(
              volume: totalVolumeM3!,
              selectedMaterialModel: selectedMaterialModel.value,
              selectedThicknessModel: selectedThicknessModel.value,
              selectedTypeModel: selectedTypeModel.value,
            ),
          );
        }
      }
    } else {
      debugPrint('Form invalid!');
    }
  }

  double _cmToM(String text) => (double.tryParse(text) ?? 0) / 100.0;

  void _calculateVolume() {
    final double L = _cmToM(fundamentLengthController.text);
    final double W = _cmToM(fundamentWidthController.text);
    final double H = _cmToM(fundamentHeightController.text);

    totalVolumeM3 = L * W * H;

    debugPrint('Net fundament volume: $totalVolumeM3 m³');
  }
}
