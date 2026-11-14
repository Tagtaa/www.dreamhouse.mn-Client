import '../base_model.dart';

final class TokenDetailsModel extends BaseModel {
  final String token;
  final String refreshToken;

  const TokenDetailsModel._({
    required this.token,
    required this.refreshToken,
  });

  factory TokenDetailsModel.fromJson(Map<String, dynamic> json) {
    return TokenDetailsModel._(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
