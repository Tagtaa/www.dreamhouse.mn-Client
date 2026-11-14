class ChooseShapeResponseModel {
  final bool? success;
  final ShapeData? data;

  const ChooseShapeResponseModel({
    this.success,
    this.data,
  });

  factory ChooseShapeResponseModel.fromJson(Map<String, dynamic> json) => ChooseShapeResponseModel(
    success: json['success'] as bool?,
    data: json['data'] != null ? ShapeData.fromJson(json['data'] as Map<String, dynamic>) : null,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data?.toJson(),
  };
}

class ShapeData {
  final List<ChooseShape>? shapeOptions;

  const ShapeData({
    this.shapeOptions,
  });

  factory ShapeData.fromJson(Map<String, dynamic> json) => ShapeData(
    shapeOptions: (json['shapeOptions'] as List<dynamic>?)?.map((e) => ChooseShape.fromJson(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'shapeOptions': shapeOptions?.map((ChooseShape e) => e.toJson()).toList(),
  };
}

class ChooseShape {
  final String? id;
  final String? calculationType;
  final String? key;
  final String? name;
  final String? imageUrl;
  final String? description;
  final bool? isActive;
  final int? sortOrder;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ChooseShape({
    this.id,
    this.calculationType,
    this.key,
    this.name,
    this.imageUrl,
    this.description,
    this.isActive,
    this.sortOrder,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory ChooseShape.fromJson(Map<String, dynamic> json) => ChooseShape(
    id: json['_id'] as String? ?? json['id'] as String?,
    calculationType: json['calculationType'] as String?,
    key: json['key'] as String?,
    name: json['name'] as String?,
    imageUrl: json['imageUrl'] as String?,
    description: json['description'] as String?,
    isActive: json['isActive'] as bool?,
    sortOrder: json['sortOrder'] as int?,
    v: json['__v'] as int?,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'] as String) : null,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'calculationType': calculationType,
    'key': key,
    'name': name,
    'imageUrl': imageUrl,
    'description': description,
    'isActive': isActive,
    'sortOrder': sortOrder,
    '__v': v,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
