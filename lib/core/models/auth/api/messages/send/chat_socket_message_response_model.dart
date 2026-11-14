import '../../../../base_model.dart';
import 'chat_message_model_data.dart';

final class ChatSocketMessageResponseModel extends BaseModel {
  final String? type;
  final ChatMessageModel? message;

  const ChatSocketMessageResponseModel({
    required this.type,
    this.message,
  });

  factory ChatSocketMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatSocketMessageResponseModel(
      type: json['type'] as String?,
      message: json['message'] != null ? ChatMessageModel.fromJson(json['message'] as Map<String, dynamic>) : null,
    );
  }
}
