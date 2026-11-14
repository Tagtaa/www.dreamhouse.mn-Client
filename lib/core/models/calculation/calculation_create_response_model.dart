import '../base_model.dart';

final class CalculationCreateResponseModel extends BaseModel {
  final bool success;
  final String message;

  const CalculationCreateResponseModel({
    required this.success,
    required this.message,
  });

  factory CalculationCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationCreateResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'message': message,
  };
}
