// import '../base_model.dart';

// final class CalculationIngredientsModel extends BaseModel {}

// final class CalculationIngredientsModelResponseModel {
//   final bool? success;
//   final CalculationIngredientsDataModel? data;

//   const CalculationIngredientsModelResponseModel({this.success, this.data});

//   factory CalculationIngredientsModelResponseModel.fromJson(Map<String, dynamic> json) => CalculationIngredientsModelResponseModel(
//     success: json['success'] as bool?,
//     data: json['data'] != null ? CalculationIngredientsDataModel.fromJson(json['data'] as Map<String, dynamic>) : null,
//   );

//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'success': success,
//     'data': data?.toJson(),
//   };
// }

// final class CalculationIngredientsDataModel {
//   final List<IngredientModel> ingredients;
//   final String? calculationType;
//   final String? query;
//   final int? total;

//   const CalculationIngredientsDataModel({
//     required this.ingredients,
//     this.calculationType,
//     this.query,
//     this.total,
//   });

//   factory CalculationIngredientsDataModel.fromJson(Map<String, dynamic> json) => CalculationIngredientsDataModel(
//     ingredients: (json['ingredients'] as List<dynamic>?)?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>)).toList() ?? <IngredientModel>[],
//     calculationType: json['calculationType'] as String?,
//     query: json['query'] as String?,
//     total: json['total'] as int?,
//   );

//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'ingredients': ingredients.map((IngredientModel e) => e.toJson()).toList(),
//     'calculationType': calculationType,
//     'query': query,
//     'total': total,
//   };
// }

// final class IngredientModel {
//   final String? id;
//   final String? name;
//   final double? requiredPercent;
//   final String? unit;
//   final double? costPerM3;
//   final double? costPerPacket;
//   final double? packageWeight;

//   const IngredientModel({
//     this.id,
//     this.name,
//     this.requiredPercent,
//     this.unit,
//     this.costPerM3,
//     this.costPerPacket,
//     this.packageWeight,
//   });

//   factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
//     id: json['id'] as String?,
//     name: json['name'] as String?,
//     requiredPercent: (json['requiredPercent'] as num?)?.toDouble(),
//     unit: json['unit'] as String?,
//     costPerM3: (json['costPerM3'] as num?)?.toDouble(),
//     costPerPacket: (json['costPerPacket'] as num?)?.toDouble(),
//     packageWeight: (json['packageWeight'] as num?)?.toDouble(),
//   );

//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'id': id,
//     'name': name,
//     'requiredPercent': requiredPercent,
//     'unit': unit,
//     'costPerM3': costPerM3,
//     'costPerPacket': costPerPacket,
//     'packageWeight': packageWeight,
//   };
// }
