import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/anonymous_messages/list/chat_messages_list_response_model.dart';
import '../../../models/auth/api/anonymous_messages/send/anonymous_chat_message_request_model.dart';
import '../../../models/auth/api/anonymous_messages/send/anonymous_chat_message_response_model.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class AnonymousMessageClient {
  final Dio _api;

  const AnonymousMessageClient(this._api);

  Future<Result<AnonymousChatMessageResponseModel, ApiException>> sendTextMessage(AnonymousChatMessageRequestModel requestModel) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.anonymousMessagesSend,
        data: requestModel.toJson(),
      );
      return Success(AnonymousChatMessageResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<AnonymousChatMessageResponseModel, ApiException>> sendImageMessage(Uint8List imageBytes, {String? sessionId}) async {
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'sessionId': sessionId,
      });

      final Response<dynamic> response = await _api.post(
        ApiPaths.anonymousMessagesSendImage,
        data: formData,
      );
      return Success(AnonymousChatMessageResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<AnonymousChatMessagesListResponseModel, ApiException>> getAllChatMessages({
    required int page,
    required int limit,
    required String sessionId,
  }) async {
    try {
      final Map<String, dynamic> queryParam = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      final Response<dynamic> response = await _api.post(
        ApiPaths.anonymousMessagesUserMessages,
        queryParameters: queryParam,
        data: <String, String>{
          'sessionId': sessionId,
        },
      );
      return Success(AnonymousChatMessagesListResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
