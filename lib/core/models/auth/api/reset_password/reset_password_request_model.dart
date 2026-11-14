import '../../../base_model.dart';

final class ResetPasswordRequestModel extends BaseModel {
  final String phone;
  final String code;
  final String password;

  const ResetPasswordRequestModel({
    required this.phone,
    required this.code,
    required this.password,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestModel(
      phone: json['phone'] as String,
      code: json['code'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'code': code,
      'password': password,
    };
  }
}
