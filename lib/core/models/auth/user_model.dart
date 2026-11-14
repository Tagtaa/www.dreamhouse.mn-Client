import '../base_model.dart';
import 'membership_model.dart';

final class UserModel extends BaseModel {
  final String id;
  final String phone;
  final String username;
  final MembershipModel membership;
  final int wallet;
  final bool isVerified;
  final String? profileImage;

  const UserModel._({
    required this.id,
    required this.phone,
    required this.username,
    required this.membership,
    required this.wallet,
    required this.isVerified,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel._(
      id: json['id'] as String,
      phone: json['phone'] as String,
      username: json['username'] as String,
      membership: MembershipModel.fromJson(json['membership']),
      wallet: json['wallet'] as int,
      isVerified: json['isVerified'] as bool,
      profileImage: json['profileImage'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'username': username,
      'membership': membership.toJson(),
      'wallet': wallet,
      'isVerified': isVerified,
      'profileImage': profileImage,
    };
  }
}
