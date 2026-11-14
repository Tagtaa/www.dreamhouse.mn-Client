import '../../../base_model.dart';

final class ForgotPasswordResponseModel extends BaseModel {
  final bool success;
  final String message;
  final ForgotPasswordResponseDataModel data;

  const ForgotPasswordResponseModel._({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel._(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ForgotPasswordResponseDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

final class ForgotPasswordResponseDataModel extends BaseModel {
  final String otpCode;
  final String sendToNumber;
  final String instructions;
  final int expiresIn;
  final String phone;

  const ForgotPasswordResponseDataModel._({
    required this.otpCode,
    required this.sendToNumber,
    required this.instructions,
    required this.expiresIn,
    required this.phone,
  });

  factory ForgotPasswordResponseDataModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseDataModel._(
      otpCode: json['otpCode'] as String,
      sendToNumber: json['sendToNumber'] as String,
      instructions: json['instructions'] as String,
      expiresIn: json['expiresIn'] as int,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'otpCode': otpCode,
      'sendToNumber': sendToNumber,
      'instructions': instructions,
      'expiresIn': expiresIn,
      'phone': phone,
    };
  }
}
