import '../../exceptions/api_exception.dart';
import '../../models/materials/category/material_category_model.dart';
import '../../models/materials/like/material_like_model.dart';
import '../../models/materials/list/material_list_model.dart';
import '../../models/result.dart';
import '../api/api_service.dart';
import '../base_service.dart';

final class MaterialService extends BaseService<MaterialService> {
  final Service<ApiService> _apiService;

  const MaterialService(
    this._apiService,
  );

  Future<Result<MaterialsResponseModel, ApiException>> getMaterials({
    required int page,
    required int limit,
    String? query,
    int? category,
    String? parentCategory,
  }) async {
    return _apiService().material
        .getMaterials(
          page: page,
          limit: limit,
          query: query,
          parentCategory: parentCategory,
          category: category,
        )
        .then(
          (Result<MaterialsResponseModel, ApiException> response) async {
            return await response.on(
              success: (MaterialsResponseModel data) async {
                return Success(data);
              },
              failure: (ApiException e) => Failure(e),
            );
          },
        );
  }

  Future<Result<MaterialCategoriesResponseModel, ApiException>> getMaterialsCategories() async {
    return _apiService().material.getMaterialsCategories().then(
      (Result<MaterialCategoriesResponseModel, ApiException> response) async {
        return await response.on(
          success: (MaterialCategoriesResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<MaterialLikedResponseItem, ApiException>> updateMaterialLikes(String id) async {
    return _apiService().material.updateMaterialLikes(id).then(
      (Result<MaterialLikedResponseItem, ApiException> response) async {
        return await response.on(
          success: (MaterialLikedResponseItem data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
