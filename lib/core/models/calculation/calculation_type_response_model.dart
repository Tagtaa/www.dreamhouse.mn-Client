import '../base_model.dart';

final class CalculationTypeResponseModel extends BaseModel {
  final bool success;
  final CalculationTypeData? data;

  const CalculationTypeResponseModel({
    required this.success,
    this.data,
  });

  factory CalculationTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationTypeResponseModel(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null ? CalculationTypeData.fromJson(json['data']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data?.toJson(),
  };
}

final class CalculationTypeData extends BaseModel {
  final List<CalculationType> types;

  const CalculationTypeData({required this.types});

  factory CalculationTypeData.fromJson(Map<String, dynamic> json) {
    return CalculationTypeData(
      types: (json['types'] as List<dynamic>? ?? <dynamic>[]).map((e) => CalculationType.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'types': types.map((CalculationType e) => e.toJson()).toList(),
  };
}

final class CalculationType extends BaseModel {
  final String key;
  final String name;
  final String? description;
  final String? icon;
  final String? imageUrl;
  final bool isPremium;

  const CalculationType({
    required this.key,
    required this.name,
    this.description,
    this.icon,
    this.imageUrl,
    required this.isPremium,
  });

  factory CalculationType.fromJson(Map<String, dynamic> json) {
    return CalculationType(
      key: json['key'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'key': key,
    'name': name,
    'description': description,
    'icon': icon,
    'imageUrl': imageUrl,
    'isPremium': isPremium,
  };
}

extension CalculationTypeExtension on CalculationType {
  String get nameMn {
    switch (key) {
      case 'wall':
        return 'Хана';
      case 'fundament':
      case 'foundation':
        return 'Суурь';
      case 'roof':
        return 'Дээвэр';
      case 'inner_wall':
        return 'Дотоод хана';
      case 'underfloor':
        return 'Шал доор';
      case 'floor_tiles':
        return 'Шалны плита';
      case 'wall_decoration':
        return 'Ханын чимэглэл';
      default:
        return key;
    }
  }
}
