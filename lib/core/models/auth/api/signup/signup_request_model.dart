import '../../../base_model.dart';

final class SignupRequestModel extends BaseModel {
  final String phone;
  final String username;
  final String password;

  SignupRequestModel({
    required this.phone,
    required this.username,
    required this.password,
  });

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) {
    return SignupRequestModel(
      phone: json['phone'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'username': username,
      'password': password,
    };
  }
}
