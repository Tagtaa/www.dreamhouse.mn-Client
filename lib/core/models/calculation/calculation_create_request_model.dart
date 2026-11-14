import '../base_model.dart';
import '../materials/list/material_list_model.dart';
import 'calculation_custom_model.dart';
import 'choose_shape_response_model.dart';
import 'choose_thickness_response_model.dart';
import 'choose_type_response_model.dart';
import 'door_window_model.dart';
import 'ing_calc_model.dart';

final class CalculationCreateRequestModel extends BaseModel {
  final ChooseType? selectedTypeModel;
  final ChooseShape? selectedShapeModel;
  final MaterialItem? selectedMaterialModel;
  final ChooseThickness? selectedThicknessModel;
  final CalculationCustomModel? calculationCustomModel;
  final double? totalPrice;
  final double? totalVolume;
  final double? totalArea;
  final int? materialItemCount;
  final List<DoorWindowModel>? doorList;
  final List<DoorWindowModel>? windowList;
  final List<IngCalcModel>? ingCalcModelList;

  const CalculationCreateRequestModel({
    this.selectedTypeModel,
    this.selectedShapeModel,
    this.selectedMaterialModel,
    this.selectedThicknessModel,
    this.calculationCustomModel,
    this.totalPrice,
    this.totalVolume,
    this.totalArea,
    this.materialItemCount,
    this.doorList,
    this.windowList,
    this.ingCalcModelList,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'selectedTypeModel': selectedTypeModel?.toJson(),
    'selectedShapeModel': selectedShapeModel?.toJson(),
    'selectedMaterialModel': selectedMaterialModel?.toJson(),
    'selectedThicknessModel': selectedThicknessModel?.toJson(),
    'calculationCustomModel': calculationCustomModel?.toJson(),
    'totalPrice': totalPrice,
    'totalVolume': totalVolume,
    'totalArea': totalArea,
    'materialItemCount': materialItemCount,
    'doorList': doorList?.map((DoorWindowModel e) => e.toJson()).toList(),
    'windowList': windowList?.map((DoorWindowModel e) => e.toJson()).toList(),
    'ingCalcModelList': ingCalcModelList?.map((IngCalcModel e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => <Object?>[
    selectedTypeModel,
    selectedShapeModel,
    selectedMaterialModel,
    selectedThicknessModel,
    calculationCustomModel,
    totalPrice,
    totalVolume,
    totalArea,
    materialItemCount,
    doorList,
    windowList,
    ingCalcModelList,
  ];
}
