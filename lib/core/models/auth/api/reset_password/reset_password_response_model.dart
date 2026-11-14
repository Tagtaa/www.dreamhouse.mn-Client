import '../../../base_model.dart';

final class ResetPasswordResponseModel extends BaseModel {
  final bool success;
  final String message;

  const ResetPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
    };
  }
}
