import '../../../base_model.dart';

final class UpdateUserRequestModel extends BaseModel {
  final String? email;
  final String? username;

  const UpdateUserRequestModel({
    this.email,
    this.username,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    if (email != null) 'email': email,
    if (username != null) 'username': username,
  };
}
