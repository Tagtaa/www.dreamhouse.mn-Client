import 'package:intl/intl.dart';

import '../../../../base_model.dart';

final class ChatMessageModel extends BaseModel {
  final String? id;
  final String? conversationId;
  final String? senderId;
  final String? senderType;
  final String? messageType;
  final String? content;
  final String? imageUrl;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ChatMessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.senderType,
    this.messageType,
    this.content,
    this.imageUrl,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'] as String?,
      conversationId: json['conversationId'] as String?,
      senderId: json['senderId'] as String?,
      senderType: json['senderType'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isRead: json['isRead'] as bool?,
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
      'senderId': senderId,
      'senderType': senderType,
      'messageType': messageType,
      'content': content,
      'imageUrl': imageUrl,
      'isRead': isRead,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  String get formattedDate => createdAt != null ? DateFormat('yyyy/MM/dd HH:mm').format(createdAt!) : '';
}
