import '../../../base_model.dart';

final class ForgotPasswordCodeRequestModel extends BaseModel {
  final String phone;

  ForgotPasswordCodeRequestModel({
    required this.phone,
  });
}
