import '../../../base_model.dart';

final class SendVerificationCodeRequestModel extends BaseModel {
  final String phone;

  SendVerificationCodeRequestModel({
    required this.phone,
  });
}
