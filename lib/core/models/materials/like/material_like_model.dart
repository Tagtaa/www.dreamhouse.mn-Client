import '../../base_model.dart';

final class MaterialLikedResponseModel extends BaseModel {
  final bool success;
  final String message;
  final MaterialLikedResponseData data;

  const MaterialLikedResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MaterialLikedResponseModel.fromJson(Map<String, dynamic> json) {
    return MaterialLikedResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: MaterialLikedResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

final class MaterialLikedResponseData {
  final MaterialLikedResponseItem material;

  const MaterialLikedResponseData({
    required this.material,
  });

  factory MaterialLikedResponseData.fromJson(Map<String, dynamic> json) {
    return MaterialLikedResponseData(
      material: MaterialLikedResponseItem.fromJson(json['material'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'material': material.toJson(),
  };
}

final class MaterialLikedResponseItem {
  final String id;
  final int likeCount;
  final bool isLiked;

  const MaterialLikedResponseItem({
    required this.id,
    required this.likeCount,
    required this.isLiked,
  });

  factory MaterialLikedResponseItem.fromJson(Map<String, dynamic> json) {
    return MaterialLikedResponseItem(
      id: json['_id'] as String,
      likeCount: json['likeCount'] as int,
      isLiked: json['isLiked'] as bool,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'likeCount': likeCount,
    'isLiked': isLiked,
  };
}
