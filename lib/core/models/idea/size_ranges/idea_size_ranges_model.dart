import '../../base_model.dart';

final class IdeaSizeRangesResponseModel extends BaseModel {
  final bool success;
  final SizeRangesData data;

  const IdeaSizeRangesResponseModel({
    required this.success,
    required this.data,
  });

  factory IdeaSizeRangesResponseModel.fromJson(Map<String, dynamic> json) {
    return IdeaSizeRangesResponseModel(
      success: json['success'] as bool,
      data: SizeRangesData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': data.toJson(),
  };
}

final class SizeRangesData {
  final List<SizeRange> sizeRanges;

  const SizeRangesData({
    required this.sizeRanges,
  });

  factory SizeRangesData.fromJson(Map<String, dynamic> json) {
    return SizeRangesData(
      sizeRanges: (json['sizeRanges'] as List<dynamic>).map((e) => SizeRange.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sizeRanges': sizeRanges.map((SizeRange e) => e.toJson()).toList(),
  };
}

final class SizeRange {
  final String value;
  final String label;

  const SizeRange({
    required this.value,
    required this.label,
  });

  factory SizeRange.fromJson(Map<String, dynamic> json) {
    return SizeRange(
      value: json['value'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': value,
    'label': label,
  };
}
