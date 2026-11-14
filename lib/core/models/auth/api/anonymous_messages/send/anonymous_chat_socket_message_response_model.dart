import '../../../../base_model.dart';
import 'anonymous_chat_message_model_data.dart';

final class AnonymousChatSocketMessageResponseModel extends BaseModel {
  final AnonymousChatMessageModel? message;
  final AnonymousConversationModel? conversation;
  final DateTime? timestamp;

  const AnonymousChatSocketMessageResponseModel({
    this.message,
    this.conversation,
    this.timestamp,
  });

  factory AnonymousChatSocketMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return AnonymousChatSocketMessageResponseModel(
      message: json['message'] != null ? AnonymousChatMessageModel.fromJson(json['message']) : null,
      conversation: json['conversation'] != null ? AnonymousConversationModel.fromJson(json['conversation']) : null,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message?.toJson(),
      'conversation': conversation?.toJson(),
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}

final class AnonymousConversationModel extends BaseModel {
  final String? id;
  final String? sessionId;
  final AnonymousUnreadCountModel? unreadCount;
  final DateTime? lastMessageAt;

  const AnonymousConversationModel({
    this.id,
    this.sessionId,
    this.unreadCount,
    this.lastMessageAt,
  });

  factory AnonymousConversationModel.fromJson(Map<String, dynamic> json) {
    return AnonymousConversationModel(
      id: json['_id'] as String?,
      sessionId: json['sessionId'] as String?,
      unreadCount: json['unreadCount'] != null ? AnonymousUnreadCountModel.fromJson(json['unreadCount']) : null,
      lastMessageAt: json['lastMessageAt'] != null ? DateTime.parse(json['lastMessageAt']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'sessionId': sessionId,
      'unreadCount': unreadCount?.toJson(),
      'lastMessageAt': lastMessageAt?.toIso8601String(),
    };
  }
}

final class AnonymousUnreadCountModel extends BaseModel {
  final int? anonymous;
  final int? admin;

  const AnonymousUnreadCountModel({
    this.anonymous,
    this.admin,
  });

  factory AnonymousUnreadCountModel.fromJson(Map<String, dynamic> json) {
    return AnonymousUnreadCountModel(
      anonymous: json['anonymous'] as int?,
      admin: json['admin'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'anonymous': anonymous,
      'admin': admin,
    };
  }
}
