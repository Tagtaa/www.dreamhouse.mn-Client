import '../base_model.dart';

final class Price {
  final num? amount;
  final String? currency;
  final String? unit;

  const Price({this.amount, this.currency, this.unit});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount'] as num?,
      currency: json['currency'] as String?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'amount': amount,
    'currency': currency,
    'unit': unit,
  };
}

final class ChooseMaterialResponseModel extends BaseModel {
  final bool success;
  final ChooseMaterialData data;

  const ChooseMaterialResponseModel({
    required this.success,
    required this.data,
  });

  factory ChooseMaterialResponseModel.fromJson(Map<String, dynamic> json) {
    return ChooseMaterialResponseModel(
      success: json['success'] as bool,
      data: ChooseMaterialData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

final class ChooseMaterialData {
  final List<ChooseMaterial> materials;
  final String? query;
  final Pagination pagination;

  const ChooseMaterialData({
    required this.materials,
    this.query,
    required this.pagination,
  });

  factory ChooseMaterialData.fromJson(Map<String, dynamic> json) {
    return ChooseMaterialData(
      materials: (json['materials'] as List<dynamic>? ?? <dynamic>[]).map((e) => ChooseMaterial.fromJson(e as Map<String, dynamic>)).toList(),
      query: json['query'] as String?,
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'materials': materials.map((ChooseMaterial e) => e.toJson()).toList(),
    'query': query,
    'pagination': pagination.toJson(),
  };
}

final class ChooseMaterial {
  final CostPerUnit? costPerUnit;
  final Supplier? supplier;
  final String? id;
  final String? name;
  final String? type;
  final String? key;
  final int? sortOrder;
  final MaterialListCategory? category;
  final Price? price;
  final String? specs;
  final num? rating;
  final num? width;
  final num? length;
  final num? height;
  final String? description;
  final List<String>? images;
  final List<Ingredient>? ingredients;
  final List<ThicknessOption>? thicknessOptions;
  final int? likeCount;
  final List<String>? likedBy;
  final bool? isLiked;
  final bool? isPremium;
  final bool? isActive;
  final List<String>? tags;
  final int? popularity;
  final int? viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? formattedPrice;

  const ChooseMaterial({
    this.costPerUnit,
    this.supplier,
    this.id,
    this.name,
    this.type,
    this.key,
    this.sortOrder,
    this.category,
    this.price,
    this.specs,
    this.rating,
    this.width,
    this.length,
    this.height,
    this.description,
    this.images,
    this.ingredients,
    this.thicknessOptions,
    this.likeCount,
    this.likedBy,
    this.isLiked,
    this.isPremium,
    this.isActive,
    this.tags,
    this.popularity,
    this.viewCount,
    this.createdAt,
    this.updatedAt,
    this.formattedPrice,
  });

  factory ChooseMaterial.fromJson(Map<String, dynamic> json) {
    return ChooseMaterial(
      costPerUnit: json['costPerUnit'] != null ? CostPerUnit.fromJson(json['costPerUnit'] as Map<String, dynamic>) : null,
      supplier: json['supplier'] != null ? Supplier.fromJson(json['supplier'] as Map<String, dynamic>) : null,
      id: json['_id'] as String?,
      name: json['name'] as String?,
      type: json['calculationType'] as String?,
      key: json['key'] as String?,
      sortOrder: json['sortOrder'] as int?,
      category: json['category'] != null ? MaterialListCategory.fromJson(json['category'] as Map<String, dynamic>) : null,
      price: json['price'] != null ? Price.fromJson(json['price'] as Map<String, dynamic>) : null,
      specs: json['specs'] as String?,
      rating: json['rating'] as num?,
      width: json['width'] as num?,
      length: json['length'] as num?,
      height: json['height'] as num?,
      description: json['description'] as String?,
      images: json['imageUrl'] != null ? <String>[json['imageUrl'] as String] : null,
      ingredients: (json['ingredients'] as List<dynamic>?)?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>)).toList(),
      thicknessOptions: (json['thicknessOptions'] as List<dynamic>?)?.map((e) => ThicknessOption.fromJson(e as Map<String, dynamic>)).toList(),
      likeCount: json['likes'] as int?,
      likedBy: (json['likedBy'] as List<dynamic>?)?.cast<String>(),
      isLiked: json['isLiked'] as bool?,
      isPremium: json['isPremium'] as bool?,
      isActive: json['isActive'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      popularity: json['popularity'] as int?,
      viewCount: json['viewCount'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'] as String) : null,
      formattedPrice: json['formattedPrice'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'costPerUnit': costPerUnit?.toJson(),
    'supplier': supplier?.toJson(),
    '_id': id,
    'name': name,
    'calculationType': type,
    'key': key,
    'sortOrder': sortOrder,
    'category': category?.toJson(),
    'price': price?.toJson(),
    'specs': specs,
    'rating': rating,
    'width': width,
    'length': length,
    'height': height,
    'description': description,
    'imageUrl': images?.firstOrNull,
    'ingredients': ingredients?.map((Ingredient e) => e.toJson()).toList(),
    'thicknessOptions': thicknessOptions?.map((ThicknessOption e) => e.toJson()).toList(),
    'likes': likeCount,
    'likedBy': likedBy,
    'isLiked': isLiked,
    'isPremium': isPremium,
    'isActive': isActive,
    'tags': tags,
    'popularity': popularity,
    'viewCount': viewCount,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'formattedPrice': formattedPrice,
  };

  ChooseMaterial copyWith({
    CostPerUnit? costPerUnit,
    Supplier? supplier,
    String? id,
    String? name,
    String? type,
    String? key,
    int? sortOrder,
    MaterialListCategory? category,
    Price? price,
    String? specs,
    num? rating,
    num? width,
    num? length,
    num? height,
    String? description,
    List<String>? images,
    List<Ingredient>? ingredients,
    List<ThicknessOption>? thicknessOptions,
    int? likeCount,
    List<String>? likedBy,
    bool? isLiked,
    bool? isPremium,
    bool? isActive,
    List<String>? tags,
    int? popularity,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? formattedPrice,
  }) {
    return ChooseMaterial(
      costPerUnit: costPerUnit ?? this.costPerUnit,
      supplier: supplier ?? this.supplier,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      key: key ?? this.key,
      sortOrder: sortOrder ?? this.sortOrder,
      category: category ?? this.category,
      price: price ?? this.price,
      specs: specs ?? this.specs,
      rating: rating ?? this.rating,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      description: description ?? this.description,
      images: images ?? this.images,
      ingredients: ingredients ?? this.ingredients,
      thicknessOptions: thicknessOptions ?? this.thicknessOptions,
      likeCount: likeCount ?? this.likeCount,
      likedBy: likedBy ?? this.likedBy,
      isLiked: isLiked ?? this.isLiked,
      isPremium: isPremium ?? this.isPremium,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      popularity: popularity ?? this.popularity,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      formattedPrice: formattedPrice ?? this.formattedPrice,
    );
  }
}

final class CostPerUnit {
  final num? perM2;
  final num? perM3;
  final String? currency;

  const CostPerUnit({this.perM2, this.perM3, this.currency});

  factory CostPerUnit.fromJson(Map<String, dynamic> json) {
    return CostPerUnit(
      perM2: json['perM2'] as num?,
      perM3: json['perM3'] as num?,
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'perM2': perM2,
    'perM3': perM3,
    'currency': currency,
  };
}

final class Supplier {
  final String? name;
  final String? contact;
  final String? location;

  const Supplier({this.name, this.contact, this.location});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'contact': contact,
    'location': location,
  };
}

final class MaterialListCategory {
  final String? id;
  final String? name;
  final ParentCategory? parentCategory;
  final List<String>? images;

  const MaterialListCategory({
    this.id,
    this.name,
    this.parentCategory,
    this.images,
  });

  factory MaterialListCategory.fromJson(Map<String, dynamic> json) {
    return MaterialListCategory(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      parentCategory: json['parentCategory'] != null ? ParentCategory.fromJson(json['parentCategory'] as Map<String, dynamic>) : null,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'parentCategory': parentCategory?.toJson(),
    'images': images,
  };
}

final class ParentCategory {
  final String? id;
  final String? name;

  const ParentCategory({
    this.id,
    this.name,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) {
    return ParentCategory(
      id: json['_id']?.toString(),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
  };
}

final class Ingredient {
  final String? name;
  final num? requiredPercent;
  final String? unit;
  final num? costPerM3;
  final num? costPerPacket;
  final num? packageWeight;

  const Ingredient({
    this.name,
    this.requiredPercent,
    this.unit,
    this.costPerM3,
    this.costPerPacket,
    this.packageWeight,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String?,
      requiredPercent: json['requiredPercent'] as num?,
      unit: json['unit'] as String?,
      costPerM3: json['costPerM3'] as num?,
      costPerPacket: json['costPerPacket'] as num?,
      packageWeight: json['packageWeight'] as num?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'requiredPercent': requiredPercent,
    'unit': unit,
    'costPerM3': costPerM3,
    'costPerPacket': costPerPacket,
    'packageWeight': packageWeight,
  };
}

final class ThicknessOption {
  final Dimension? thickness;
  final String? fileUrl;
  final String? id;

  const ThicknessOption({this.thickness, this.fileUrl, this.id});

  factory ThicknessOption.fromJson(Map<String, dynamic> json) {
    return ThicknessOption(
      thickness: json['thickness'] != null ? Dimension.fromJson(json['thickness'] as Map<String, dynamic>) : null,
      fileUrl: json['fileUrl'] as String?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'thickness': thickness?.toJson(),
    'fileUrl': fileUrl,
    '_id': id,
  };
}

final class Dimension {
  final num? value;
  final String? unit;

  const Dimension({this.value, this.unit});

  factory Dimension.fromJson(Map<String, dynamic> json) {
    return Dimension(
      value: json['value'] as num?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': value,
    'unit': unit,
  };
}

final class Pagination {
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

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'page': page,
    'limit': limit,
    'total': total,
    'pages': pages,
  };
}
