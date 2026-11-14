import 'package:dio/dio.dart';
import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/models/materials/list/material_list_model.dart';
import '../../../../core/models/result.dart';
import '../../../models/materials/category/material_category_model.dart';
import '../../../models/materials/like/material_like_model.dart';
import '../constants/api_paths.dart';

final class MaterialClient {
  final Dio _api;

  const MaterialClient(this._api);

  Future<Result<MaterialsResponseModel, ApiException>> getMaterials({
    required int page,
    required int limit,
    String? query,
    int? category,
    String? parentCategory,
  }) async {
    final Map<String, dynamic> queryParam = <String, dynamic>{
      'page': page,
      'limit': limit,
      'category': category,
      'parentCategory': parentCategory,
    };
    if (query != null && query.trim().isNotEmpty) {
      queryParam.addAll(<String, dynamic>{'q': query});
    }

    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getMaterials,
        queryParameters: queryParam,
      );
      return Success(MaterialsResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<MaterialCategoriesResponseModel, ApiException>> getMaterialsCategories() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getMaterialCategories,
      );
      return Success(MaterialCategoriesResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<MaterialLikedResponseItem, ApiException>> updateMaterialLikes(String id) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.updateMaterialLikes.replaceFirst(':id', id),
      );
      return Success(MaterialLikedResponseModel.fromJson(response.data).data.material);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
