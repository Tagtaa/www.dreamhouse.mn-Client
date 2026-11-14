import 'package:intl/intl.dart';

import '../../../../base_model.dart';

final class AnonymousChatMessageData extends BaseModel {
  final AnonymousChatMessageModel? message;
  final String? sessionId;
  final String? nickname;

  const AnonymousChatMessageData({
    this.message,
    this.sessionId,
    this.nickname,
  });

  factory AnonymousChatMessageData.fromJson(Map<String, dynamic> json) {
    return AnonymousChatMessageData(
      message: json['message'] != null ? AnonymousChatMessageModel.fromJson(json['message'] as Map<String, dynamic>) : null,
      sessionId: json['sessionId'] as String?,
      nickname: json['nickname'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message?.toJson(),
      'sessionId': sessionId,
      'nickname': nickname,
    };
  }
}

final class AnonymousChatMessageModel extends BaseModel {
  final String? id;
  final String? conversationId;
  final String? sessionId;
  final String? senderType;
  final String? messageType;
  final String? content;
  final String? imageUrl;
  final bool? isRead;
  final AnonymousSenderMetadata? senderMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const AnonymousChatMessageModel({
    this.id,
    this.conversationId,
    this.sessionId,
    this.senderType,
    this.messageType,
    this.content,
    this.imageUrl,
    this.isRead,
    this.senderMetadata,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AnonymousChatMessageModel.fromJson(Map<String, dynamic> json) {
    return AnonymousChatMessageModel(
      id: json['_id'] as String?,
      conversationId: json['conversationId'] as String?,
      sessionId: json['sessionId'] as String?,
      senderType: json['senderType'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isRead: json['isRead'] as bool?,
      senderMetadata: json['senderMetadata'] != null ? AnonymousSenderMetadata.fromJson(json['senderMetadata'] as Map<String, dynamic>) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'conversationId': conversationId,
      'sessionId': sessionId,
      'senderType': senderType,
      'messageType': messageType,
      'content': content,
      'imageUrl': imageUrl,
      'isRead': isRead,
      'senderMetadata': senderMetadata?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  String get formattedDate => createdAt != null ? DateFormat('yyyy/MM/dd HH:mm').format(createdAt!) : '';
}

final class AnonymousSenderMetadata extends BaseModel {
  final String? ipAddress;
  final String? userAgent;
  final String? nickname;

  const AnonymousSenderMetadata({
    this.ipAddress,
    this.userAgent,
    this.nickname,
  });

  factory AnonymousSenderMetadata.fromJson(Map<String, dynamic> json) {
    return AnonymousSenderMetadata(
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['userAgent'] as String?,
      nickname: json['nickname'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ipAddress': ipAddress,
      'userAgent': userAgent,
      'nickname': nickname,
    };
  }
}
