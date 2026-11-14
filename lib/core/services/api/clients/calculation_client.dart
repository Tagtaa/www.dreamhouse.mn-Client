import 'package:dio/dio.dart';

import '../../../exceptions/api_exception.dart';
import '../../../models/calculation/calculation_create_request_model.dart';
import '../../../models/calculation/calculation_create_response_model.dart';
import '../../../models/calculation/calculation_history_response_model.dart';
import '../../../models/calculation/calculation_type_response_model.dart';
import '../../../models/calculation/choose_material_response_model.dart';
import '../../../models/calculation/choose_shape_response_model.dart';
import '../../../models/calculation/choose_thickness_response_model.dart';
import '../../../models/calculation/choose_type_response_model.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class CalculationClient {
  final Dio _api;

  const CalculationClient(this._api);

  Future<Result<CalculationTypeResponseModel, ApiException>> getTypes() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.calculationsTypes,
      );
      return Success(CalculationTypeResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<CalculationHistoryResponseModel, ApiException>> getCalculationHistory({
    required int page,
    required int limit,
  }) async {
    try {
      final Map<String, dynamic> queryParam = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      final Response<dynamic> response = await _api.get(
        ApiPaths.getCalculationHistory,
        queryParameters: queryParam,
      );
      return Success(CalculationHistoryResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChooseTypesResponseModel, ApiException>> getChooseTypes({required String type}) async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.calculationsChooseTypes.replaceFirst(':type', type),
      );
      return Success(ChooseTypesResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChooseMaterialResponseModel, ApiException>> getChooseMaterials({required String material}) async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.calculationsChooseMaterials.replaceFirst(':type', material),
      );
      return Success(ChooseMaterialResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChooseThicknessResponseModel, ApiException>> getChooseThickness() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.calculationsWallThicknessTypes,
      );
      return Success(ChooseThicknessResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChooseShapeResponseModel, ApiException>> getChooseShapes() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.calculationsRoofShapesTypes,
      );
      return Success(ChooseShapeResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  // Future<Result<CalculationIngredientsModelResponseModel, ApiException>> getCalculationIngredients({required String type}) async {
  //   try {
  //     final Response<dynamic> response = await _api.get(
  //       ApiPaths.calculationsIngredients.replaceFirst(':type', type),
  //     );
  //     return Success(CalculationIngredientsModelResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     return Failure(ApiException.from(e));
  //   }
  // }

  Future<Result<CalculationCreateResponseModel, ApiException>> createCalculation({required CalculationCreateRequestModel model}) async {
    try {
      final Map<String, dynamic> x = model.toJson();
      final Response<dynamic> response = await _api.post(
        ApiPaths.calculations,
        data: model.toJson(),
      );
      return Success(CalculationCreateResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<bool, ApiException>> deleteHistoryCalculation({required String id}) async {
    try {
      final Response<dynamic> response = await _api.delete(
        ApiPaths.deleteCalculation.replaceFirst(':id', id),
      );
      return const Success(true);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<CalculationDetailResponseModel, ApiException>> getCalculationDetail({required String id}) async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getCalculationById.replaceFirst(':id', id),
      );
      return Success(CalculationDetailResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
