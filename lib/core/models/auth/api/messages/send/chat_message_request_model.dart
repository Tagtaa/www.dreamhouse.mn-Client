import '../../../../base_model.dart';

final class ChatMessageRequestModel extends BaseModel {
  final String content;

  const ChatMessageRequestModel({
    required this.content,
  });

  factory ChatMessageRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageRequestModel(
      content: json['content'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
    };
  }
}
