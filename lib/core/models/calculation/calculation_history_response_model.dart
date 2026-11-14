import '../../configs/constants/text_constants.dart';
import '../base_model.dart';

final class CalculationHistoryResponseModel extends BaseModel {
  final bool success;
  final CalculationHistoryData data;

  const CalculationHistoryResponseModel({
    required this.success,
    required this.data,
  });

  factory CalculationHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationHistoryResponseModel(
      success: json['success'] as bool? ?? false,
      data: CalculationHistoryData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

class CalculationHistoryData {
  final User? user;
  final List<CalculationHistory> calculations;
  final Pagination pagination;

  const CalculationHistoryData({
    this.user,
    this.calculations = const <CalculationHistory>[],
    required this.pagination,
  });

  factory CalculationHistoryData.fromJson(Map<String, dynamic> json) {
    return CalculationHistoryData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      calculations: (json['calculations'] as List<dynamic>?)?.map((e) => CalculationHistory.fromJson(e)).toList() ?? <CalculationHistory>[],
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'user': user?.toJson(),
    'calculations': calculations.map((CalculationHistory e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class User {
  final String? id;
  final String? phone;
  final String? username;
  final String? displayName;

  const User({this.id, this.phone, this.username, this.displayName});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] as String?,
    phone: json['phone'] as String?,
    username: json['username'] as String?,
    displayName: json['displayName'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'phone': phone,
    'username': username,
    'displayName': displayName,
  };
}

class CalculationHistory {
  final Inputs? inputs;
  final Results? results;
  final String? id;
  final String? type;
  final String? status;
  final bool? isBookmarked;
  final bool? isShared;
  final List<String>? tags;
  final List<String>? sharedWith;
  final String? lastAccessed;
  final String? lastAccessedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? typeName;
  final String? materialName;
  final String? materialImageUrl;

  final dynamic shapeInfo;
  final dynamic thicknessInfo;

  final Summary? summary;
  final num? totalPrice;

  const CalculationHistory({
    this.inputs,
    this.results,
    this.id,
    this.type,
    this.status,
    this.isBookmarked,
    this.isShared,
    this.tags,
    this.sharedWith,
    this.lastAccessed,
    this.lastAccessedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.typeName,
    this.materialName,
    this.materialImageUrl,
    this.shapeInfo,
    this.thicknessInfo,
    this.summary,
    this.totalPrice,
  });

  factory CalculationHistory.fromJson(Map<String, dynamic> json) => CalculationHistory(
    inputs: json['inputs'] != null ? Inputs.fromJson(json['inputs']) : null,
    results: json['results'] != null ? Results.fromJson(json['results']) : null,
    id: json['_id'],
    type: json['type'],
    status: json['status'],
    isBookmarked: json['isBookmarked'],
    isShared: json['isShared'],
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    sharedWith: (json['sharedWith'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    lastAccessed: json['lastAccessed'],
    lastAccessedAt: json['lastAccessedAt'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
    typeName: json['typeName'],
    materialName: json['materialName'],
    materialImageUrl: json['materialImageUrl'],
    shapeInfo: json['shapeInfo'],
    thicknessInfo: json['thicknessInfo'],
    summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
    totalPrice: json['totalPrice'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'inputs': inputs?.toJson(),
    'results': results?.toJson(),
    '_id': id,
    'type': type,
    'status': status,
    'isBookmarked': isBookmarked,
    'isShared': isShared,
    'tags': tags,
    'sharedWith': sharedWith,
    'lastAccessed': lastAccessed,
    'lastAccessedAt': lastAccessedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'typeName': typeName,
    'materialName': materialName,
    'materialImageUrl': materialImageUrl,
    'shapeInfo': shapeInfo,
    'thicknessInfo': thicknessInfo,
    'summary': summary?.toJson(),
    'totalPrice': totalPrice,
  };
}

///
/// INPUTS MODEL
/// MUST INCLUDE ALL KEYS FROM JSON
///
class Inputs {
  final dynamic selectedTypeModel;
  final dynamic selectedShapeModel;
  final dynamic selectedThicknessModel;
  final dynamic calculationCustomModel;

  final dynamic selectedMaterialModel;
  final num? totalPrice;
  final num? totalArea;
  final num? totalVolume;
  final num? materialItemCount;

  final List<dynamic>? doorList;
  final List<dynamic>? windowList;

  final List<IngCalcModel>? ingCalcModelList;

  final num? blockLength;
  final num? blockWidth;
  final num? blockHeight;
  final num? blockThickness;

  final String? imageUrl;
  final List<dynamic>? windows;
  final List<dynamic>? doors;
  final bool? includeWaste;
  final num? wastePercentage;

  const Inputs({
    this.selectedTypeModel,
    this.selectedShapeModel,
    this.selectedThicknessModel,
    this.calculationCustomModel,
    this.selectedMaterialModel,
    this.totalPrice,
    this.totalArea,
    this.totalVolume,
    this.materialItemCount,
    this.doorList,
    this.windowList,
    this.ingCalcModelList,
    this.blockLength,
    this.blockWidth,
    this.blockHeight,
    this.blockThickness,
    this.imageUrl,
    this.windows,
    this.doors,
    this.includeWaste,
    this.wastePercentage,
  });

  factory Inputs.fromJson(Map<String, dynamic> json) => Inputs(
    selectedTypeModel: json['selectedTypeModel'],
    selectedShapeModel: json['selectedShapeModel'],
    selectedThicknessModel: json['selectedThicknessModel'],
    calculationCustomModel: json['calculationCustomModel'],
    selectedMaterialModel: json['selectedMaterialModel'],
    totalPrice: json['totalPrice'],
    totalArea: json['totalArea'],
    totalVolume: json['totalVolume'],
    materialItemCount: json['materialItemCount'],
    doorList: json['doorList'],
    windowList: json['windowList'],
    ingCalcModelList: (json['ingCalcModelList'] as List<dynamic>?)?.map((e) => IngCalcModel.fromJson(e)).toList(),
    blockLength: json['blockLength'],
    blockWidth: json['blockWidth'],
    blockHeight: json['blockHeight'],
    blockThickness: json['blockThickness'],
    imageUrl: json['imageUrl'],
    windows: json['windows'],
    doors: json['doors'],
    includeWaste: json['includeWaste'],
    wastePercentage: json['wastePercentage'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'selectedTypeModel': selectedTypeModel,
    'selectedShapeModel': selectedShapeModel,
    'selectedThicknessModel': selectedThicknessModel,
    'calculationCustomModel': calculationCustomModel,
    'selectedMaterialModel': selectedMaterialModel,
    'totalPrice': totalPrice,
    'totalArea': totalArea,
    'totalVolume': totalVolume,
    'materialItemCount': materialItemCount,
    'doorList': doorList,
    'windowList': windowList,
    'ingCalcModelList': ingCalcModelList?.map((IngCalcModel e) => e.toJson()).toList(),
    'blockLength': blockLength,
    'blockWidth': blockWidth,
    'blockHeight': blockHeight,
    'blockThickness': blockThickness,
    'imageUrl': imageUrl,
    'windows': windows,
    'doors': doors,
    'includeWaste': includeWaste,
    'wastePercentage': wastePercentage,
  };
}

class IngCalcModel {
  final String? id;
  final String? name;
  final String? unit;
  final num? percentValue;
  final num? pricePerM3;
  final num? pricePerM2;
  // Legacy fields for backward compatibility
  final num? amount;
  final num? price;

  const IngCalcModel({
    this.id,
    this.name,
    this.unit,
    this.percentValue,
    this.pricePerM3,
    this.pricePerM2,
    this.amount,
    this.price,
  });

  factory IngCalcModel.fromJson(Map<String, dynamic> json) => IngCalcModel(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    unit: json['unit'] as String?,
    percentValue: json['percentValue'] as num?,
    pricePerM3: json['pricePerM3'] as num?,
    pricePerM2: json['pricePerM2'] as num?,
    // Legacy fields
    amount: json['amount'] as num?,
    price: json['price'] as num?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'unit': unit,
    'percentValue': percentValue,
    'pricePerM3': pricePerM3,
    'pricePerM2': pricePerM2,
    // Legacy fields
    'amount': amount,
    'price': price,
  };

  /// Get the price based on unit type
  num? get priceValue {
    if (unit == 'm3') {
      return pricePerM3 ?? price;
    } else if (unit == 'm2') {
      return pricePerM2 ?? price;
    }
    return price ?? pricePerM3 ?? pricePerM2;
  }

  /// Get the amount (for backward compatibility)
  num? get amountValue {
    return amount ?? percentValue;
  }
}

///
/// RESULTS MODEL
///
class Results {
  final num? area;
  final num? volume;
  final num? perimeter;

  final List<dynamic>? materials;
  final List<dynamic>? ingredients;

  final num? totalArea;
  final num? totalVolume;
  final num? totalMaterialCost;
  final num? estimatedLaborCost;
  final num? totalCost;

  final List<dynamic>? additionalCosts;
  final dynamic openings;

  const Results({
    this.area,
    this.volume,
    this.perimeter,
    this.materials,
    this.ingredients,
    this.totalArea,
    this.totalVolume,
    this.totalMaterialCost,
    this.estimatedLaborCost,
    this.totalCost,
    this.additionalCosts,
    this.openings,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    area: json['area'],
    volume: json['volume'],
    perimeter: json['perimeter'],
    materials: json['materials'],
    ingredients: json['ingredients'],
    totalArea: json['totalArea'],
    totalVolume: json['totalVolume'],
    totalMaterialCost: json['totalMaterialCost'],
    estimatedLaborCost: json['estimatedLaborCost'],
    totalCost: json['totalCost'],
    additionalCosts: json['additionalCosts'],
    openings: json['openings'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'area': area,
    'volume': volume,
    'perimeter': perimeter,
    'materials': materials,
    'ingredients': ingredients,
    'totalArea': totalArea,
    'totalVolume': totalVolume,
    'totalMaterialCost': totalMaterialCost,
    'estimatedLaborCost': estimatedLaborCost,
    'totalCost': totalCost,
    'additionalCosts': additionalCosts,
    'openings': openings,
  };
}

class Summary {
  final num? totalPrice;
  final num? totalVolume;
  final num? totalArea;
  final num? materialItemCount;
  final num? doorCount;
  final num? windowCount;
  final num? ingredientCount;

  const Summary({
    this.totalPrice,
    this.totalVolume,
    this.totalArea,
    this.materialItemCount,
    this.doorCount,
    this.windowCount,
    this.ingredientCount,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalPrice: json['totalPrice'],
    totalVolume: json['totalVolume'],
    totalArea: json['totalArea'],
    materialItemCount: json['materialItemCount'],
    doorCount: json['doorCount'],
    windowCount: json['windowCount'],
    ingredientCount: json['ingredientCount'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'totalPrice': totalPrice,
    'totalVolume': totalVolume,
    'totalArea': totalArea,
    'materialItemCount': materialItemCount,
    'doorCount': doorCount,
    'windowCount': windowCount,
    'ingredientCount': ingredientCount,
  };
}

///
/// PAGINATION
///
class Pagination {
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

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json['page'],
    limit: json['limit'],
    total: json['total'],
    pages: json['pages'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'page': page,
    'limit': limit,
    'total': total,
    'pages': pages,
  };
}

///
/// CALCULATION DETAIL RESPONSE MODEL
///
final class CalculationDetailResponseModel extends BaseModel {
  final bool success;
  final CalculationDetailData data;

  const CalculationDetailResponseModel({
    required this.success,
    required this.data,
  });

  factory CalculationDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationDetailResponseModel(
      success: json['success'] as bool? ?? false,
      data: CalculationDetailData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

class CalculationDetailData {
  final CalculationDetail calculation;

  const CalculationDetailData({
    required this.calculation,
  });

  factory CalculationDetailData.fromJson(Map<String, dynamic> json) {
    return CalculationDetailData(
      calculation: CalculationDetail.fromJson(json['calculation']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'calculation': calculation.toJson(),
  };
}

class CalculationDetail {
  final String? id;
  final String? type;
  final Inputs? inputs;
  final List<DoorDetail>? doorDetails;
  final List<WindowDetail>? windowDetails;
  final CalculationSummary? calculationSummary;

  const CalculationDetail({
    this.id,
    this.type,
    this.inputs,
    this.doorDetails,
    this.windowDetails,
    this.calculationSummary,
  });

  factory CalculationDetail.fromJson(Map<String, dynamic> json) => CalculationDetail(
    id: json['_id'],
    type: json['type'],
    inputs: json['inputs'] != null ? Inputs.fromJson(json['inputs']) : null,
    doorDetails: (json['doorDetails'] as List<dynamic>?)?.map((e) => DoorDetail.fromJson(e)).toList(),
    windowDetails: (json['windowDetails'] as List<dynamic>?)?.map((e) => WindowDetail.fromJson(e)).toList(),
    calculationSummary: json['calculationSummary'] != null ? CalculationSummary.fromJson(json['calculationSummary']) : null,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'type': type,
    'inputs': inputs?.toJson(),
    'doorDetails': doorDetails?.map((DoorDetail e) => e.toJson()).toList(),
    'windowDetails': windowDetails?.map((WindowDetail e) => e.toJson()).toList(),
    'calculationSummary': calculationSummary?.toJson(),
  };
}

class DoorDetail {
  final int id;
  final num width;
  final num height;
  final String area;
  final String formattedArea;

  const DoorDetail({
    required this.id,
    required this.width,
    required this.height,
    required this.area,
    required this.formattedArea,
  });

  factory DoorDetail.fromJson(Map<String, dynamic> json) => DoorDetail(
    id: json['id'] as int,
    width: json['width'] as num,
    height: json['height'] as num,
    area: json['area'] as String,
    formattedArea: json['formattedArea'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'width': width,
    'height': height,
    'area': area,
    'formattedArea': formattedArea,
  };
}

class WindowDetail {
  final int id;
  final num width;
  final num height;
  final String area;
  final String formattedArea;

  const WindowDetail({
    required this.id,
    required this.width,
    required this.height,
    required this.area,
    required this.formattedArea,
  });

  factory WindowDetail.fromJson(Map<String, dynamic> json) => WindowDetail(
    id: json['id'] as int,
    width: json['width'] as num,
    height: json['height'] as num,
    area: json['area'] as String,
    formattedArea: json['formattedArea'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'width': width,
    'height': height,
    'area': area,
    'formattedArea': formattedArea,
  };
}

class CalculationSummary {
  final num? totalPrice;
  final num? totalVolume;
  final num? totalArea;
  final num? materialItemCount;
  final num? doorCount;
  final num? windowCount;
  final num? ingredientCount;
  final String? formattedPrice;

  const CalculationSummary({
    this.totalPrice,
    this.totalVolume,
    this.totalArea,
    this.materialItemCount,
    this.doorCount,
    this.windowCount,
    this.ingredientCount,
    this.formattedPrice,
  });

  factory CalculationSummary.fromJson(Map<String, dynamic> json) => CalculationSummary(
    totalPrice: json['totalPrice'],
    totalVolume: json['totalVolume'],
    totalArea: json['totalArea'],
    materialItemCount: json['materialItemCount'],
    doorCount: json['doorCount'],
    windowCount: json['windowCount'],
    ingredientCount: json['ingredientCount'],
    formattedPrice: json['formattedPrice'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'totalPrice': totalPrice,
    'totalVolume': totalVolume,
    'totalArea': totalArea,
    'materialItemCount': materialItemCount,
    'doorCount': doorCount,
    'windowCount': windowCount,
    'ingredientCount': ingredientCount,
    'formattedPrice': formattedPrice,
  };
}

extension DateTimeExtensions on String? {
  String get timeAgo {
    if (this == null || this!.isEmpty) {
      return TextConstants.timeAgoJustNow;
    }

    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this!);
    } catch (_) {
      return TextConstants.timeAgoJustNow;
    }

    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365}${TextConstants.timeAgoYears}';
    }

    if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30}${TextConstants.timeAgoMonths}';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays}${TextConstants.timeAgoDays}';
    }

    if (difference.inHours > 0) {
      return '${difference.inHours}${TextConstants.timeAgoHours}';
    }

    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}${TextConstants.timeAgoMinutes}';
    }

    return TextConstants.timeAgoJustNow;
  }
}
