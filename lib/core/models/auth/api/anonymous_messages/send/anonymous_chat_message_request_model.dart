import '../../../../base_model.dart';

final class AnonymousChatMessageRequestModel extends BaseModel {
  final String content;
  final String? nickname;
  final String? sessionId;

  const AnonymousChatMessageRequestModel({
    required this.content,
    this.nickname,
    this.sessionId,
  });

  factory AnonymousChatMessageRequestModel.fromJson(Map<String, dynamic> json) {
    return AnonymousChatMessageRequestModel(
      content: json['content'] as String,
      nickname: json['nickname'] as String?,
      sessionId: json['sessionId'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      if (nickname != null) 'nickname': nickname,
      if (sessionId != null) 'sessionId': sessionId,
    };
  }
}
