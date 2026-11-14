import '../../base_model.dart';

final class IdeaListResponseModel extends BaseModel {
  final bool success;
  final IdeaListData data;

  const IdeaListResponseModel({
    required this.success,
    required this.data,
  });

  factory IdeaListResponseModel.fromJson(Map<String, dynamic> json) {
    return IdeaListResponseModel(
      success: json['success'] as bool,
      data: IdeaListData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

final class IdeaListData {
  final List<IdeaItem> ideas;
  final String? query;
  final Pagination pagination;

  const IdeaListData({
    required this.ideas,
    this.query,
    required this.pagination,
  });

  factory IdeaListData.fromJson(Map<String, dynamic> json) {
    return IdeaListData(
      ideas: (json['ideas'] as List<dynamic>? ?? <dynamic>[]).map((e) => IdeaItem.fromJson(e as Map<String, dynamic>)).toList(),
      query: json['query'] as String?,
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'ideas': ideas.map((IdeaItem e) => e.toJson()).toList(),
    'query': query,
    'pagination': pagination.toJson(),
  };
}

final class IdeaItem {
  final Size? size;
  final Rating? rating;
  final String? id;
  final String? title;
  final Category? category;
  final HeatingType? heatingType;
  final String? description;
  final String? shortDetail;
  final List<ImageModel>? images;
  final num? totalCost;
  final num? purchasePrice;
  final int? soldCount;
  final List<AddItem>? addItem;
  final bool? isPremium;
  final bool? isPurchased;
  final bool? isActive;
  final bool? isPublished;
  final bool? isFeatured;
  final List<String>? tags;
  final int? popularity;
  final int? viewCount;
  final int? likeCount;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isPremiumLocked;

  const IdeaItem({
    this.size,
    this.rating,
    this.id,
    this.title,
    this.category,
    this.heatingType,
    this.description,
    this.shortDetail,
    this.images,
    this.totalCost,
    this.purchasePrice,
    this.soldCount,
    this.addItem,
    this.isPremium,
    this.isPurchased,
    this.isActive,
    this.isPublished,
    this.isFeatured,
    this.tags,
    this.popularity,
    this.viewCount,
    this.likeCount,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.isPremiumLocked,
  });

  factory IdeaItem.fromJson(Map<String, dynamic> json) {
    return IdeaItem(
      size: json['size'] != null ? Size.fromJson(json['size'] as Map<String, dynamic>) : null,
      rating: json['rating'] != null ? Rating.fromJson(json['rating'] as Map<String, dynamic>) : null,
      id: json['_id'] as String?,
      title: json['title'] as String?,
      category: json['category'] != null ? Category.fromJson(json['category'] as Map<String, dynamic>) : null,
      heatingType: json['heatingType'] != null ? HeatingType.fromJson(json['heatingType'] as Map<String, dynamic>) : null,
      description: json['description'] as String?,
      shortDetail: json['shortDetail'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>)).toList(),
      totalCost: json['totalCost'] as num?,
      purchasePrice: json['purchasePrice'] as num?,
      soldCount: json['soldCount'] as int?,
      addItem: (json['addItem'] as List<dynamic>?)?.map((e) => AddItem.fromJson(e as Map<String, dynamic>)).toList(),
      isPremium: json['isPremium'] as bool?,
      isPurchased: json['isPurchased'] as bool?,
      isActive: json['isActive'] as bool?,
      isPublished: json['isPublished'] as bool?,
      isFeatured: json['isFeatured'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      popularity: json['popularity'] as int?,
      viewCount: json['viewCount'] as int?,
      likeCount: json['likeCount'] as int?,
      v: json['__v'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'] as String) : null,
      isPremiumLocked: json['isPremiumLocked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'size': size?.toJson(),
    'rating': rating?.toJson(),
    '_id': id,
    'title': title,
    'category': category?.toJson(),
    'heatingType': heatingType?.toJson(),
    'description': description,
    'shortDetail': shortDetail,
    'images': images?.map((ImageModel e) => e.toJson()).toList(),
    'totalCost': totalCost,
    'purchasePrice': purchasePrice,
    'soldCount': soldCount,
    'addItem': addItem?.map((AddItem e) => e.toJson()).toList(),
    'isPremium': isPremium,
    'isPurchased': isPurchased,
    'isActive': isActive,
    'isPublished': isPublished,
    'isFeatured': isFeatured,
    'tags': tags,
    'popularity': popularity,
    'viewCount': viewCount,
    'likeCount': likeCount,
    '__v': v,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'isPremiumLocked': isPremiumLocked,
  };
}

final class Size {
  final num? value;
  final String? unit;

  const Size({this.value, this.unit});

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      value: json['value'] as num?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': value,
    'unit': unit,
  };
}

final class Rating {
  final num? average;
  final int? count;

  const Rating({this.average, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average'] as num?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'average': average,
    'count': count,
  };
}

final class Category {
  final int? id;
  final String? name;
  final String? description;

  const Category({this.id, this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'description': description,
  };
}

final class HeatingType {
  final int? id;
  final String? name;
  final String? description;

  const HeatingType({this.id, this.name, this.description});

  factory HeatingType.fromJson(Map<String, dynamic> json) {
    return HeatingType(
      id: json['_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'name': name,
    'description': description,
  };
}

final class ImageModel {
  final String? url;
  final String? caption;
  final bool? isPrimary;
  final String? id;

  const ImageModel({this.url, this.caption, this.isPrimary, this.id});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] as String?,
      caption: json['caption'] as String?,
      isPrimary: json['isPrimary'] as bool?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'caption': caption,
    'isPrimary': isPrimary,
    '_id': id,
  };
}

final class AddItem {
  final String? itemName;
  final num? itemQuantity;
  final num? itemPrice;
  final String? id;

  const AddItem({this.itemName, this.itemQuantity, this.itemPrice, this.id});

  factory AddItem.fromJson(Map<String, dynamic> json) {
    return AddItem(
      itemName: json['itemName'] as String?,
      itemQuantity: json['itemQuantity'] as num?,
      itemPrice: json['itemPrice'] as num?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'itemName': itemName,
    'itemQuantity': itemQuantity,
    'itemPrice': itemPrice,
    '_id': id,
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
