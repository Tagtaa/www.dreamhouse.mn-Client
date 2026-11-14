class ChooseThicknessResponseModel {
  final bool? success;
  final ThicknessData? data;

  const ChooseThicknessResponseModel({
    this.success,
    this.data,
  });

  factory ChooseThicknessResponseModel.fromJson(Map<String, dynamic> json) => ChooseThicknessResponseModel(
    success: json['success'] as bool?,
    data: json['data'] != null ? ThicknessData.fromJson(json['data'] as Map<String, dynamic>) : null,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data?.toJson(),
  };
}

class ThicknessData {
  final List<ChooseThickness>? thicknessOptions;

  const ThicknessData({
    this.thicknessOptions,
  });

  factory ThicknessData.fromJson(Map<String, dynamic> json) => ThicknessData(
    thicknessOptions: (json['thicknessOptions'] as List<dynamic>?)?.map((e) => ChooseThickness.fromJson(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'thicknessOptions': thicknessOptions?.map((ChooseThickness e) => e.toJson()).toList(),
  };
}

class ChooseThickness {
  final String? id;
  final String? calculationType;
  final String? key;
  final String? name;
  final int? thickness;
  final String? unit;
  final String? imageUrl;
  final String? description;
  final bool? isActive;
  final int? sortOrder;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ChooseThickness({
    this.id,
    this.calculationType,
    this.key,
    this.name,
    this.thickness,
    this.unit,
    this.imageUrl,
    this.description,
    this.isActive,
    this.sortOrder,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory ChooseThickness.fromJson(Map<String, dynamic> json) => ChooseThickness(
    id: json['_id'] as String? ?? json['id'] as String?,
    calculationType: json['calculationType'] as String?,
    key: json['key'] as String?,
    name: json['name'] as String?,
    thickness: json['thickness'] as int?,
    unit: json['unit'] as String?,
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
    'thickness': thickness,
    'unit': unit,
    'imageUrl': imageUrl,
    'description': description,
    'isActive': isActive,
    'sortOrder': sortOrder,
    '__v': v,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
