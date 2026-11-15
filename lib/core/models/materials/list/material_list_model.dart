import '../../base_model.dart';

final class MaterialsResponseModel extends BaseModel {
  final bool success;
  final MaterialsData data;

  const MaterialsResponseModel({
    required this.success,
    required this.data,
  });

  factory MaterialsResponseModel.fromJson(Map<String, dynamic> json) {
    return MaterialsResponseModel(
      success: json['success'] as bool,
      data: MaterialsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

final class MaterialsData {
  final List<MaterialItem> materials;
  final String? query;
  final Pagination pagination;

  const MaterialsData({
    required this.materials,
    this.query,
    required this.pagination,
  });

  factory MaterialsData.fromJson(Map<String, dynamic> json) {
    return MaterialsData(
      materials: (json['materials'] as List<dynamic>? ?? <dynamic>[]).map((e) => MaterialItem.fromJson(e as Map<String, dynamic>)).toList(),
      query: json['query'] as String?,
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'materials': materials.map((MaterialItem e) => e.toJson()).toList(),
    'query': query,
    'pagination': pagination.toJson(),
  };
}

/// Where to buy the material — the API sends it to users with an active membership only.
final class MaterialContact {
  final String? phone;
  final String? address;
  final String? mapEmbedUrl;

  const MaterialContact({this.phone, this.address, this.mapEmbedUrl});

  bool get isEmpty => (phone ?? '').isEmpty && (address ?? '').isEmpty && (mapEmbedUrl ?? '').isEmpty;

  factory MaterialContact.fromJson(Map<String, dynamic> json) => MaterialContact(
    phone: json['phone'] as String?,
    address: json['address'] as String?,
    mapEmbedUrl: json['mapEmbedUrl'] as String?,
  );
}

final class MaterialItem {
  final MaterialContact? contact;
  final CostPerUnit? costPerUnit;
  final Supplier? supplier;
  final String? id;
  final String? name;
  final MaterialListCategory? category;
  final num? price;
  final String? specs;
  final num? rating;
  final num? width;
  final num? length;
  final num? height;
  final String? unit;
  final String? description;
  final List<String>? images;
  final List<ThicknessOption>? thicknessOptions;
  final int? likeCount;
  final List<String>? likedBy;
  final bool? isLiked;
  final bool? isPremium;
  final bool? isActive;
  final List<String>? tags;
  final int? popularity;
  final int? viewCount;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? formattedPrice;

  const MaterialItem({
    this.costPerUnit,
    this.supplier,
    this.id,
    this.name,
    this.category,
    this.price,
    this.specs,
    this.rating,
    this.width,
    this.length,
    this.height,
    this.unit,
    this.description,
    this.images,
    this.thicknessOptions,
    this.likeCount,
    this.likedBy,
    this.isLiked,
    this.isPremium,
    this.isActive,
    this.tags,
    this.popularity,
    this.viewCount,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.formattedPrice,
    this.contact,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      costPerUnit: json['costPerUnit'] != null ? CostPerUnit.fromJson(json['costPerUnit'] as Map<String, dynamic>) : null,
      supplier: json['supplier'] != null ? Supplier.fromJson(json['supplier'] as Map<String, dynamic>) : null,
      id: json['_id'] as String?,
      name: json['name'] as String?,
      category: json['category'] != null ? MaterialListCategory.fromJson(json['category'] as Map<String, dynamic>) : null,
      price: json['price'] as num?,
      specs: json['specs'] as String?,
      rating: json['rating'] as num?,
      width: json['width'] as num?,
      length: json['length'] as num?,
      height: json['height'] as num?,
      unit: json['unit'] as String?,
      description: json['description'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      thicknessOptions: json['thicknessOptions'] != null
          ? (json['thicknessOptions'] as List<dynamic>?)?.where((e) => e != null).map((e) => ThicknessOption.fromJson(e as Map<String, dynamic>)).toList()
          : null,
      likeCount: json['likeCount'] as int?,
      likedBy: (json['likedBy'] as List<dynamic>?)?.cast<String>(),
      isLiked: json['isLiked'] as bool?,
      isPremium: json['isPremium'] as bool?,
      isActive: json['isActive'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      popularity: json['popularity'] as int?,
      viewCount: json['viewCount'] as int?,
      v: json['__v'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'] as String) : null,
      formattedPrice: json['formattedPrice'] as String?,
      contact: json['contact'] is Map<String, dynamic> ? MaterialContact.fromJson(json['contact'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'costPerUnit': costPerUnit?.toJson(),
    'supplier': supplier?.toJson(),
    '_id': id,
    'name': name,
    'category': category?.toJson(),
    'price': price,
    'specs': specs,
    'rating': rating,
    'width': width,
    'length': length,
    'height': height,
    'unit': unit,
    'description': description,
    'images': images,
    'thicknessOptions': thicknessOptions?.map((ThicknessOption e) => e.toJson()).toList(),
    'likeCount': likeCount,
    'likedBy': likedBy,
    'isLiked': isLiked,
    'isPremium': isPremium,
    'isActive': isActive,
    'tags': tags,
    'popularity': popularity,
    'viewCount': viewCount,
    '__v': v,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'formattedPrice': formattedPrice,
    'id': id, // JSON'da hem _id hem de id var
  };

  MaterialItem copyWith({
    CostPerUnit? costPerUnit,
    Supplier? supplier,
    String? id,
    String? name,
    MaterialListCategory? category,
    num? price,
    String? specs,
    num? rating,
    num? width,
    num? length,
    num? height,
    String? unit,
    String? description,
    List<String>? images,
    List<ThicknessOption>? thicknessOptions,
    int? likeCount,
    List<String>? likedBy,
    bool? isLiked,
    bool? isPremium,
    bool? isActive,
    List<String>? tags,
    int? popularity,
    int? viewCount,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? formattedPrice,
  }) {
    return MaterialItem(
      costPerUnit: costPerUnit ?? this.costPerUnit,
      supplier: supplier ?? this.supplier,
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      specs: specs ?? this.specs,
      rating: rating ?? this.rating,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      unit: unit ?? this.unit,
      description: description ?? this.description,
      images: images ?? this.images,
      thicknessOptions: thicknessOptions ?? this.thicknessOptions,
      likeCount: likeCount ?? this.likeCount,
      likedBy: likedBy ?? this.likedBy,
      isLiked: isLiked ?? this.isLiked,
      isPremium: isPremium ?? this.isPremium,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      popularity: popularity ?? this.popularity,
      viewCount: viewCount ?? this.viewCount,
      v: v ?? this.v,
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
  final List<Ingredient>? ingredients;

  const MaterialListCategory({
    this.id,
    this.name,
    this.parentCategory,
    this.images,
    this.ingredients,
  });

  factory MaterialListCategory.fromJson(Map<String, dynamic> json) {
    return MaterialListCategory(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      parentCategory: json['parentCategory'] != null ? ParentCategory.fromJson(json['parentCategory'] as Map<String, dynamic>) : null,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      ingredients: json['ingredients'] != null ? (json['ingredients'] as List<dynamic>?)?.where((e) => e != null).map((e) => Ingredient.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'parentCategory': parentCategory?.toJson(),
    'images': images,
    'ingredients': ingredients?.map((Ingredient e) => e.toJson()).toList(),
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
  final String? id;
  final String? name;
  final String? unit;
  // For m2 unit
  final num? m2Amount;
  final num? pricePerM2;
  // For m3 unit
  final num? m3Amount;
  final num? pricePerM3;
  // For kg/percent unit
  final num? percentValue;
  final num? priceForPer1Percent;
  // Legacy fields (nullable)
  final num? requiredPercent;
  final num? costPerM3;

  const Ingredient({
    this.id,
    this.name,
    this.unit,
    this.m2Amount,
    this.pricePerM2,
    this.m3Amount,
    this.pricePerM3,
    this.percentValue,
    this.priceForPer1Percent,
    this.requiredPercent,
    this.costPerM3,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      unit: json['unit'] as String?,
      m2Amount: json['m2Amount'] as num?,
      pricePerM2: json['pricePerM2'] as num?,
      m3Amount: json['m3Amount'] as num?,
      pricePerM3: json['pricePerM3'] as num?,
      percentValue: json['percentValue'] as num?,
      priceForPer1Percent: json['priceForPer1Percent'] as num?,
      requiredPercent: json['requiredPercent'] as num?,
      costPerM3: json['costPerM3'] as num?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'unit': unit,
    'm2Amount': m2Amount,
    'pricePerM2': pricePerM2,
    'm3Amount': m3Amount,
    'pricePerM3': pricePerM3,
    'percentValue': percentValue,
    'priceForPer1Percent': priceForPer1Percent,
    'requiredPercent': requiredPercent,
    'costPerM3': costPerM3,
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
