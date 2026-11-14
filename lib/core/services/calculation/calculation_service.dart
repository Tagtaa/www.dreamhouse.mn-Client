import '../../exceptions/api_exception.dart';
import '../../models/calculation/calculation_create_request_model.dart';
import '../../models/calculation/calculation_create_response_model.dart';
import '../../models/calculation/calculation_custom_model.dart';
//import '../../models/calculation/calculation_history_response_model.dart';
//import '../../models/calculation/calculation_ingredients_model.dart';
import '../../models/calculation/calculation_history_response_model.dart' hide IngCalcModel;
import '../../models/calculation/calculation_type_response_model.dart';
import '../../models/calculation/choose_material_response_model.dart';
import '../../models/calculation/choose_shape_response_model.dart';
import '../../models/calculation/choose_thickness_response_model.dart';
import '../../models/calculation/choose_type_response_model.dart';
import '../../models/calculation/door_window_model.dart';
import '../../models/calculation/ing_calc_model.dart';
import '../../models/materials/list/material_list_model.dart';
import '../../models/result.dart';
import '../api/api_service.dart';
import '../base_service.dart';

final class CalculationService extends BaseService<CalculationService> {
  final Service<ApiService> _apiService;

  const CalculationService(
    this._apiService,
  );

  Future<Result<CalculationTypeResponseModel, ApiException>> getTypes() async {
    return _apiService().calculation.getTypes().then(
      (Result<CalculationTypeResponseModel, ApiException> response) async {
        return await response.on(
          success: (CalculationTypeResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<CalculationHistoryResponseModel, ApiException>> getCalculationHistory({
    required int page,
    required int limit,
  }) async {
    return _apiService().calculation.getCalculationHistory(page: page, limit: limit).then(
      (Result<CalculationHistoryResponseModel, ApiException> response) async {
        return await response.on(
          success: (CalculationHistoryResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChooseTypesResponseModel, ApiException>> getChooseTypes({required String type}) async {
    return _apiService().calculation.getChooseTypes(type: type).then(
      (Result<ChooseTypesResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChooseTypesResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChooseMaterialResponseModel, ApiException>> getChooseMaterials({required String material}) async {
    return _apiService().calculation.getChooseMaterials(material: material).then(
      (Result<ChooseMaterialResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChooseMaterialResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChooseThicknessResponseModel, ApiException>> getChooseThickness() async {
    return _apiService().calculation.getChooseThickness().then(
      (Result<ChooseThicknessResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChooseThicknessResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChooseShapeResponseModel, ApiException>> getChooseShapes() async {
    return _apiService().calculation.getChooseShapes().then(
      (Result<ChooseShapeResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChooseShapeResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  // Future<Result<CalculationIngredientsModelResponseModel, ApiException>> getCalculationIngredients({required String type}) async {
  //   return _apiService().calculation.getCalculationIngredients(type: type).then(
  //     (Result<CalculationIngredientsModelResponseModel, ApiException> response) async {
  //       return await response.on(
  //         success: (CalculationIngredientsModelResponseModel data) async {
  //           return Success(data);
  //         },
  //         failure: (ApiException e) => Failure(e),
  //       );
  //     },
  //   );
  // }

  Future<Result<CalculationCreateResponseModel, ApiException>> createCalculation({
    ChooseType? selectedTypeModel,
    ChooseShape? selectedShapeModel,
    MaterialItem? selectedMaterialModel,
    ChooseThickness? selectedThicknessModel,
    CalculationCustomModel? calculationCustomModel,
    double? totalPrice,
    double? totalVolume,
    double? totalArea,
    int? materialItemCount,
    List<DoorWindowModel>? doorList,
    List<DoorWindowModel>? windowList,
    List<IngCalcModel>? ingCalcModelList,
  }) async {
    final CalculationCreateRequestModel requestModel = CalculationCreateRequestModel(
      selectedTypeModel: selectedTypeModel,
      selectedMaterialModel: selectedMaterialModel,
      selectedShapeModel: selectedShapeModel,
      selectedThicknessModel: selectedThicknessModel,
      calculationCustomModel: calculationCustomModel,
      totalPrice: totalPrice,
      totalVolume: totalVolume,
      totalArea: totalArea,
      materialItemCount: materialItemCount,
      doorList: doorList,
      windowList: windowList,
      ingCalcModelList: ingCalcModelList,
    );

    return _apiService().calculation.createCalculation(model: requestModel).then(
      (Result<CalculationCreateResponseModel, ApiException> response) async {
        return await response.on(
          success: (CalculationCreateResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<bool, ApiException>> deleteHistoryCalculation({required String id}) async {
    return _apiService().calculation.deleteHistoryCalculation(id: id).then(
      (Result<bool, ApiException> response) async {
        return await response.on(
          success: (bool data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
