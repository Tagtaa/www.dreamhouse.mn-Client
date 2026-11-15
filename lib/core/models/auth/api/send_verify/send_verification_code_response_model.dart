import '../../../base_model.dart';

final class SendVerificationCodeResponseModel extends BaseModel {
  final bool success;
  final String message;
  final VerificationData data;

  SendVerificationCodeResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SendVerificationCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return SendVerificationCodeResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: VerificationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

final class VerificationData extends BaseModel {
  final String otpCode;
  final String sendToNumber;
  final String instructions;
  final int expiresIn;
  final String phone;
  // false when "Phone verification" is turned off in the dashboard → skip the SMS step
  final bool requiresSmsConfirmation;

  VerificationData({
    required this.otpCode,
    required this.sendToNumber,
    required this.instructions,
    required this.expiresIn,
    required this.phone,
    this.requiresSmsConfirmation = true,
  });

  factory VerificationData.fromJson(Map<String, dynamic> json) {
    return VerificationData(
      otpCode: json['otpCode'] as String,
      sendToNumber: json['sendToNumber'] as String,
      instructions: json['instructions'] as String,
      expiresIn: json['expiresIn'] as int,
      phone: json['phone'] as String,
      requiresSmsConfirmation: json['requiresSmsConfirmation'] as bool? ?? true,
    );
  }
}
