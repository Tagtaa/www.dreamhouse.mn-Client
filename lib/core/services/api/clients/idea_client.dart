import 'package:dio/dio.dart';

import '../../../exceptions/api_exception.dart';
import '../../../models/idea/detail/idea_detail.dart';
import '../../../models/idea/list/idea_list_model.dart';
import '../../../models/idea/list/purchased_idea_list_model.dart';
import '../../../models/idea/purchase/idea_purchase_response_model.dart';
import '../../../models/idea/size_ranges/idea_size_ranges_model.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class IdeaClient {
  final Dio _api;

  const IdeaClient(this._api);

  Future<Result<IdeaListResponseModel, ApiException>> getIdeas({
    required int page,
    required int limit,
    String? query,
    String? sizeRange,
  }) async {
    final Map<String, dynamic> queryParam = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (query != null && query.trim().isNotEmpty) {
      queryParam.addAll(<String, dynamic>{'q': query});
    }

    if (sizeRange != null && sizeRange.trim().isNotEmpty && sizeRange != 'all') {
      queryParam.addAll(<String, dynamic>{'sizeRange': sizeRange});
    }

    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getIdeas,
        queryParameters: queryParam,
      );
      return Success(IdeaListResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<IdeaDetailResponseModel, ApiException>> getIdeaDetail({required String ideaId}) async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getIdeaById.replaceFirst(':id', ideaId),
      );
      return Success(IdeaDetailResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<IdeaSizeRangesResponseModel, ApiException>> getIdeaSizeRanges() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getIdeaSizeRanges,
      );
      return Success(IdeaSizeRangesResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<IdeaPurchaseResponseModel, ApiException>> purchaseIdea({required String ideaId}) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.purchaseIdea.replaceFirst(':id', ideaId),
      );
      return Success(IdeaPurchaseResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<PurchasedIdeaListModel, ApiException>> getPurchasedIdeas() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.userPurchasedIdea,
      );
      return Success(PurchasedIdeaListModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
