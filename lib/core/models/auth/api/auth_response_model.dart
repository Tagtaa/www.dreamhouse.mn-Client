import '../../base_model.dart';
import '../token_details_model.dart';
import '../user_model.dart';

final class AuthResponseModel extends BaseModel {
  final bool success;
  final String message;
  final UserModel user;
  final TokenDetailsModel tokenDetails;

  const AuthResponseModel._({
    required this.success,
    required this.message,
    required this.user,
    required this.tokenDetails,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'] as Map<String, dynamic>;
    return AuthResponseModel._(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: UserModel.fromJson(data['user']),
      tokenDetails: TokenDetailsModel.fromJson(data),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': <String, dynamic>{
        'user': user.toJson(),
        ...tokenDetails.toJson(),
      },
    };
  }
}
