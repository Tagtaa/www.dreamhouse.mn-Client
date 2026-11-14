import '../../../../base_model.dart';
import 'anonymous_chat_message_model_data.dart';

final class AnonymousChatMessageResponseModel extends BaseModel {
  final bool success;
  final String? message;
  final AnonymousChatMessageData? data;

  const AnonymousChatMessageResponseModel({
    required this.success,
    this.message,
    this.data,
  });

  factory AnonymousChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return AnonymousChatMessageResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] != null ? AnonymousChatMessageData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}
