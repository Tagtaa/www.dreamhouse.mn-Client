import '../base_model.dart';

final class CalculationCustomModel extends BaseModel {
  final double? blockLength;
  final double? blockWidth;
  final double? blockHeight;
  final double? blockThickness;
  final double? price;
  final String? imageUrl;

  const CalculationCustomModel({
    this.blockLength,
    this.blockWidth,
    this.blockHeight,
    this.blockThickness,
    this.price,
    this.imageUrl,
  });

  factory CalculationCustomModel.fromJson(Map<String, dynamic> json) => CalculationCustomModel(
    blockLength: (json['blockLength'] as num?)?.toDouble(),
    blockWidth: (json['blockWidth'] as num?)?.toDouble(),
    blockHeight: (json['blockHeight'] as num?)?.toDouble(),
    blockThickness: (json['blockThickness'] as num?)?.toDouble(),
    price: (json['price'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'blockLength': blockLength,
    'blockWidth': blockWidth,
    'blockHeight': blockHeight,
    'blockThickness': blockThickness,
    'price': price,
    'imageUrl': imageUrl,
  };
  String get specs => '1 хэсэг / $blockLength x $blockWidth x $blockHeight';
}
