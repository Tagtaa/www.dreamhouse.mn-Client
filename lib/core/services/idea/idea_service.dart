import '../../exceptions/api_exception.dart';
import '../../models/idea/detail/idea_detail.dart';
import '../../models/idea/list/idea_list_model.dart';
import '../../models/idea/list/purchased_idea_list_model.dart';
import '../../models/idea/purchase/idea_purchase_response_model.dart';
import '../../models/idea/size_ranges/idea_size_ranges_model.dart';
import '../../models/result.dart';
import '../api/api_service.dart';
import '../base_service.dart';

final class IdeaService extends BaseService<IdeaService> {
  final Service<ApiService> _apiService;

  const IdeaService(
    this._apiService,
  );

  Future<Result<IdeaListResponseModel, ApiException>> getIdeas({
    required int page,
    required int limit,
    String? query,
    String? sizeRange,
  }) async {
    return _apiService().idea.getIdeas(page: page, limit: limit, query: query, sizeRange: sizeRange).then(
      (Result<IdeaListResponseModel, ApiException> response) async {
        return await response.on(
          success: (IdeaListResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<IdeaDetailResponseModel, ApiException>> getIdeaDetail({required String ideaId}) async {
    return _apiService().idea.getIdeaDetail(ideaId: ideaId).then(
      (Result<IdeaDetailResponseModel, ApiException> response) async {
        return await response.on(
          success: (IdeaDetailResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<IdeaSizeRangesResponseModel, ApiException>> getIdeaSizeRanges() async {
    return _apiService().idea.getIdeaSizeRanges().then(
      (Result<IdeaSizeRangesResponseModel, ApiException> response) async {
        return await response.on(
          success: (IdeaSizeRangesResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<IdeaPurchaseResponseModel, ApiException>> purchaseIdea({required String ideaId}) async {
    return _apiService().idea.purchaseIdea(ideaId: ideaId).then(
      (Result<IdeaPurchaseResponseModel, ApiException> response) async {
        return await response.on(
          success: (IdeaPurchaseResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<PurchasedIdeaListModel, ApiException>> getPurchasedIdeas() async {
    return _apiService().idea.getPurchasedIdeas().then(
      (Result<PurchasedIdeaListModel, ApiException> response) async {
        return await response.on(
          success: (PurchasedIdeaListModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
