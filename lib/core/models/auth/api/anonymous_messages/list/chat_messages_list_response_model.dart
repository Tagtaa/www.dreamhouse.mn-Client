import '../../../../base_model.dart';
import '../send/anonymous_chat_message_model_data.dart';

final class AnonymousChatMessagesListResponseModel extends BaseModel {
  final bool success;
  final List<AnonymousChatMessageModel>? messages;
  final AnonymousConversationModel? conversation;
  final Pagination pagination;

  const AnonymousChatMessagesListResponseModel({
    required this.success,
    this.messages,
    this.conversation,
    required this.pagination,
  });

  factory AnonymousChatMessagesListResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;

    return AnonymousChatMessagesListResponseModel(
      success: json['success'] as bool? ?? false,
      messages: (data?['messages'] as List<dynamic>?)?.map((e) => AnonymousChatMessageModel.fromJson(e as Map<String, dynamic>)).toList(),
      conversation: data?['conversation'] != null ? AnonymousConversationModel.fromJson(data?['conversation'] as Map<String, dynamic>) : null,
      pagination: Pagination.fromJson(
        data?['pagination'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'data': <String, Object?>{
        'messages': messages?.map((AnonymousChatMessageModel e) => e.toJson()).toList(),
        'conversation': conversation?.toJson(),
        'pagination': pagination.toJson(),
      },
    };
  }
}

final class AnonymousConversationModel extends BaseModel {
  final String? id;
  final AnonymousUnreadCountModel? unreadCount;

  const AnonymousConversationModel({
    this.id,
    this.unreadCount,
  });

  factory AnonymousConversationModel.fromJson(Map<String, dynamic> json) {
    return AnonymousConversationModel(
      id: json['id'] as String?,
      unreadCount: json['unreadCount'] != null ? AnonymousUnreadCountModel.fromJson(json['unreadCount'] as Map<String, dynamic>) : null,
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

final class AnonymousUnreadCountModel extends BaseModel {
  final int? user;
  final int? admin;

  const AnonymousUnreadCountModel({
    this.user,
    this.admin,
  });

  factory AnonymousUnreadCountModel.fromJson(Map<String, dynamic> json) {
    return AnonymousUnreadCountModel(
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
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 50,
      total: json['total'] as int? ?? 0,
      pages: json['pages'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'page': page,
    'limit': limit,
    'total': total,
    'pages': pages,
  };
}
