import '../../base_model.dart';

final class MaterialCategoriesResponseModel extends BaseModel {
  final bool success;
  final CategoriesData data;

  const MaterialCategoriesResponseModel({
    required this.success,
    required this.data,
  });

  factory MaterialCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return MaterialCategoriesResponseModel(
      success: json['success'] as bool,
      data: CategoriesData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

final class CategoriesData {
  final List<MaterialCategory> categories;

  const CategoriesData({
    required this.categories,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      categories: (json['parentCategories'] as List<dynamic>).map((e) => MaterialCategory.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'parentCategories': categories.map((MaterialCategory e) => e.toJson()).toList(),
  };
}

final class MaterialCategory {
  final int id;
  final String name;

  const MaterialCategory({
    required this.id,
    required this.name,
  });

  factory MaterialCategory.fromJson(Map<String, dynamic> json) {
    return MaterialCategory(
      id: json['_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
  };
}

extension MaterialCategoryExtension on MaterialCategory {
  String get nameMn {
    switch (name) {
      case 'All':
        return 'Бүгд';
      case 'wall':
      case 'Wall':
        return 'Хана';
      case 'fundament':
      case 'Fundament':
      case 'foundation':
        return 'Суурь';
      case 'roof':
      case 'Roof':
        return 'Дээвэр';
      case 'inner_wall':
      case 'Inner Wall':
        return 'Дотоод хана';
      case 'underfloor':
      case 'Floor':
        return 'Шал';
      case 'floor_tiles':
      case 'Floor Tiles':
        return 'Шалны плита';
      case 'wall_decoration':
      case 'Wall decoration':
        return 'Ханын чимэглэл';
      default:
        return name;
    }
  }
}
