import '../../../base_model.dart';

final class SubscriptionsResponseModel extends BaseModel {
  final bool success;
  final List<SubscriptionModel> subscriptions;

  const SubscriptionsResponseModel._({
    required this.success,
    required this.subscriptions,
  });

  factory SubscriptionsResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = (json['data']['subscriptions'] as List<dynamic>);
    return SubscriptionsResponseModel._(
      success: json['success'] as bool,
      subscriptions: list.map((e) => SubscriptionModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'data': <String, dynamic>{
        'subscriptions': subscriptions.map((SubscriptionModel e) => e.toJson()).toList(),
      },
    };
  }
}

final class SubscriptionModel {
  final String id;
  final String name;
  final String plan;
  final int day;
  final int price;
  final bool isActive;
  final String title;

  const SubscriptionModel({
    required this.id,
    required this.name,
    required this.plan,
    required this.day,
    required this.price,
    required this.isActive,
    required this.title,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      plan: json['plan'] as String,
      day: json['day'] as int,
      price: json['price'] as int,
      isActive: json['isActive'] as bool,
      title: json['title'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'plan': plan,
      'day': day,
      'price': price,
      'isActive': isActive,
      'title': title,
    };
  }
}
