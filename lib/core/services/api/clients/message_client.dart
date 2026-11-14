import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/messages/list/chat_messages_list_response_model.dart';
import '../../../models/auth/api/messages/send/chat_message_response_model.dart';
import '../../../models/auth/api/messages/send/chat_message_request_model.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class MessageClient {
  final Dio _api;

  const MessageClient(this._api);

  Future<Result<ChatMessageResponseModel, ApiException>> sendTextMessage(ChatMessageRequestModel requestModel) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.messagesSend,
        data: requestModel.toJson(),
      );
      return Success(ChatMessageResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChatMessageResponseModel, ApiException>> sendImageMessage(Uint8List imageBytes) async {
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final Response<dynamic> response = await _api.post(
        ApiPaths.messagesSendImage,
        data: formData,
      );
      return Success(ChatMessageResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ChatMessagesListResponseModel, ApiException>> getAllChatMessages({
    required int page,
    required int limit,
  }) async {
    try {
      final Map<String, dynamic> queryParam = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      final Response<dynamic> response = await _api.get(
        ApiPaths.messagesUserMessages,
        queryParameters: queryParam,
      );
      return Success(ChatMessagesListResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
