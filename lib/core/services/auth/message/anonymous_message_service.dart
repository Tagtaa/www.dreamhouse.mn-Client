import 'dart:typed_data';

import '../../../../ui/screens/base_screen_controller.dart';
import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/anonymous_messages/list/chat_messages_list_response_model.dart';
import '../../../models/auth/api/anonymous_messages/send/anonymous_chat_message_request_model.dart';
import '../../../models/auth/api/anonymous_messages/send/anonymous_chat_message_response_model.dart';
import '../../../models/result.dart';
import '../../api/api_service.dart';
import '../../base_service.dart' hide Service;

final class AnonymousMessageService extends BaseService<AnonymousMessageService> {
  final Service<ApiService> _apiService;

  const AnonymousMessageService(
    this._apiService,
  );

  Future<Result<AnonymousChatMessageResponseModel, ApiException>> sendTextMessage({
    required String content,
    String? nickname,
    String? sessionId,
  }) async {
    final AnonymousChatMessageRequestModel chatMessageRequestModel = AnonymousChatMessageRequestModel(
      content: content,
      nickname: nickname,
      sessionId: sessionId,
    );

    return _apiService().anonymousMessage.sendTextMessage(chatMessageRequestModel).then(
      (Result<AnonymousChatMessageResponseModel, ApiException> response) async {
        return await response.on(
          success: (AnonymousChatMessageResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<AnonymousChatMessageResponseModel, ApiException>> sendImageMessage(Uint8List imageBytes, {String? sessionId}) async {
    return _apiService().anonymousMessage.sendImageMessage(imageBytes, sessionId: sessionId).then(
      (Result<AnonymousChatMessageResponseModel, ApiException> response) async {
        return await response.on(
          success: (AnonymousChatMessageResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<AnonymousChatMessagesListResponseModel, ApiException>> getAllChatMessages({required int page, required int limit, required String sessionId}) async {
    return _apiService().anonymousMessage.getAllChatMessages(page: page, limit: limit, sessionId: sessionId).then(
      (Result<AnonymousChatMessagesListResponseModel, ApiException> response) async {
        return await response.on(
          success: (AnonymousChatMessagesListResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
