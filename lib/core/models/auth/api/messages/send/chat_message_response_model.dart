import '../../../../base_model.dart';
import 'chat_message_model_data.dart';

final class ChatMessageResponseModel extends BaseModel {
  final bool success;
  final ChatMessageModel? data;

  const ChatMessageResponseModel({
    required this.success,
    this.data,
  });

  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponseModel(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null ? ChatMessageModel.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'data': data?.toJson(),
    };
  }
}
