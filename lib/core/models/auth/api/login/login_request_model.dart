import '../../../base_model.dart';

final class LoginRequestModel extends BaseModel {
  final String phone;
  final String password;

  LoginRequestModel({
    required this.phone,
    required this.password,
  });
}
