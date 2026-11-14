class ChooseTypesResponseModel {
  final bool success;
  final WallChooseTypesData data;

  const ChooseTypesResponseModel({
    required this.success,
    required this.data,
  });

  factory ChooseTypesResponseModel.fromJson(Map<String, dynamic> json) => ChooseTypesResponseModel(
    success: json['success'] as bool,
    data: WallChooseTypesData.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

class WallChooseTypesData {
  final List<ChooseType> types;

  const WallChooseTypesData({required this.types});

  factory WallChooseTypesData.fromJson(Map<String, dynamic> json) => WallChooseTypesData(
    types: (json['types'] as List<dynamic>).map((e) => ChooseType.fromJson(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'types': types.map((ChooseType e) => e.toJson()).toList(),
  };
}

class ChooseType {
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

  const ChooseType({
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

  factory ChooseType.fromJson(Map<String, dynamic> json) => ChooseType(
    id: json['id'] as String?,
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
