import '../base_model.dart';

final class IngCalcModel extends BaseModel {
  final String name;
  final String unit;
  final double amount;
  final double price;

  const IngCalcModel({
    required this.name,
    required this.unit,
    required this.amount,
    required this.price,
  });

  factory IngCalcModel.fromJson(Map<String, dynamic> json) {
    return IngCalcModel(
      name: json['name'] as String,
      unit: json['unit'] as String,
      amount: (json['amount'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'unit': unit,
    'amount': amount,
    'price': price,
  };

  IngCalcModel copyWith({
    String? name,
    String? unit,
    double? amount,
    double? price,
  }) {
    return IngCalcModel(
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => <Object?>[name, unit, amount, price];
}
