import '../../base_model.dart';

final class IdeaCategoryResponseModel extends BaseModel {
  final bool success;
  final IdeaCategoryData data;

  const IdeaCategoryResponseModel({
    required this.success,
    required this.data,
  });

  factory IdeaCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return IdeaCategoryResponseModel(
      success: json['success'] as bool,
      data: IdeaCategoryData.fromJson(json['data']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'data': data.toJson(),
    };
  }
}

final class IdeaCategoryData extends BaseModel {
  final List<IdeaCategory> categories;

  const IdeaCategoryData({
    required this.categories,
  });

  factory IdeaCategoryData.fromJson(Map<String, dynamic> json) {
    return IdeaCategoryData(
      categories: (json['categories'] as List<dynamic>).map((e) => IdeaCategory.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categories': categories.map((IdeaCategory e) => e.toJson()).toList(),
    };
  }
}

final class IdeaCategory extends BaseModel {
  final String key;
  final String name;
  final String description;
  final String icon;

  const IdeaCategory({
    required this.key,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory IdeaCategory.fromJson(Map<String, dynamic> json) {
    return IdeaCategory(
      key: json['key'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'name': name,
      'description': description,
      'icon': icon,
    };
  }
}
