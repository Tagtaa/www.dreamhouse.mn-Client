import '../../../../base_model.dart';
import '../send/chat_message_model_data.dart';

final class ChatMessagesListResponseModel extends BaseModel {
  final bool success;
  final List<ChatMessageModel>? messagesData;
  final ConversationModel? conversation;
  final Pagination pagination;

  const ChatMessagesListResponseModel({
    required this.success,
    this.messagesData,
    this.conversation,
    required this.pagination,
  });

  factory ChatMessagesListResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessagesListResponseModel(
      success: json['success'] as bool? ?? false,
      messagesData: (json['data'] as List<dynamic>?)?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>)).toList(),
      conversation: json['conversation'] != null
          ? ConversationModel.fromJson(
              json['conversation'] as Map<String, dynamic>,
            )
          : null,
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'data': messagesData?.map((ChatMessageModel e) => e.toJson()).toList(),
      'conversation': conversation?.toJson(),
      'pagination': pagination.toJson(),
    };
  }
}

final class ConversationModel extends BaseModel {
  final String? id;
  final UnreadCountModel? unreadCount;

  const ConversationModel({
    this.id,
    this.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String?,
      unreadCount: json['unreadCount'] != null ? UnreadCountModel.fromJson(json['unreadCount']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'unreadCount': unreadCount?.toJson(),
    };
  }
}

final class UnreadCountModel extends BaseModel {
  final int? user;
  final int? admin;

  const UnreadCountModel({
    this.user,
    this.admin,
  });

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) {
    return UnreadCountModel(
      user: json['user'] as int?,
      admin: json['admin'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user': user,
      'admin': admin,
    };
  }
}

final class Pagination {
  final int page;
  final int limit;
  final int total;
  final int pages;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'page': page,
    'limit': limit,
    'total': total,
    'pages': pages,
  };
}
