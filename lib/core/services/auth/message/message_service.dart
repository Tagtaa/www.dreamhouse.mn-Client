import 'dart:typed_data';

import '../../../../ui/screens/base_screen_controller.dart';
import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/messages/list/chat_messages_list_response_model.dart';
import '../../../models/auth/api/messages/send/chat_message_request_model.dart';
import '../../../models/auth/api/messages/send/chat_message_response_model.dart';
import '../../../models/result.dart';
import '../../api/api_service.dart';
import '../../base_service.dart' hide Service;

final class MessageService extends BaseService<MessageService> {
  final Service<ApiService> _apiService;

  const MessageService(
    this._apiService,
  );

  Future<Result<ChatMessageResponseModel, ApiException>> sendTextMessage({
    required String content,
  }) async {
    final ChatMessageRequestModel chatMessageRequestModel = ChatMessageRequestModel(content: content);

    return _apiService().message.sendTextMessage(chatMessageRequestModel).then(
      (Result<ChatMessageResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChatMessageResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChatMessageResponseModel, ApiException>> sendImageMessage(Uint8List imageBytes) async {
    return _apiService().message.sendImageMessage(imageBytes).then(
      (Result<ChatMessageResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChatMessageResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ChatMessagesListResponseModel, ApiException>> getAllChatMessages({
    required int page,
    required int limit,
  }) async {
    return _apiService().message.getAllChatMessages(page: page, limit: limit).then(
      (Result<ChatMessagesListResponseModel, ApiException> response) async {
        return await response.on(
          success: (ChatMessagesListResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }
}
