import '../../../../../../../core/models/calculation/calculation_custom_model.dart';
import '../../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../core/models/calculation/door_window_model.dart';
import '../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../base_screen_args.dart';

final class CalculationScreenArgs extends BaseScreenArgs {
  final ChooseType? selectedTypeModel;
  final MaterialItem? selectedMaterialModel;
  final ChooseThickness? selectedThicknessModel;
  final ChooseShape? selectedShapeModel;
  final CalculationCustomModel? calculationCustomModel;
  final List<DoorWindowModel>? doorList;
  final List<DoorWindowModel>? windowList;
  final double? volume;
  final double? area;
  final int? materialItemCount;
  final double? priceOneBlock;

  CalculationScreenArgs({
    this.volume,
    this.area,
    this.selectedTypeModel,
    this.selectedMaterialModel,
    this.selectedThicknessModel,
    this.selectedShapeModel,
    this.calculationCustomModel,
    this.doorList,
    this.windowList,
    this.materialItemCount,
    this.priceOneBlock,
  });
}
