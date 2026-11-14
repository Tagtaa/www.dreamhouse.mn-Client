import '../../../base_model.dart';

final class UserResponseModel extends BaseModel {
  final bool? success;
  final UserModel? user;

  UserResponseModel({this.success, this.user});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;
    return UserResponseModel(
      success: json['success'] as bool?,
      user: data != null && data['user'] != null ? UserModel.fromJson(data['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'data': user != null ? <String, Map<String, dynamic>>{'user': user!.toJson()} : null,
  };
}

final class UserModel extends BaseModel {
  final String? id;
  final String? phone;
  final String? email;
  final String? username;
  final bool? isVerified;
  final bool? isAdmin;
  final int? wallet;
  final String? profileImage;
  final bool? isActive;
  final DateTime? lastLogin;
  final List<dynamic>? purchasedIdeas;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? banReason;
  final DateTime? bannedAt;
  final bool? isBanned;
  final String? role;
  final String? displayName;
  final UserMembershipModel? membership;

  UserModel({
    this.id,
    this.phone,
    this.email,
    this.username,
    this.isVerified,
    this.isAdmin,
    this.wallet,
    this.profileImage,
    this.isActive,
    this.lastLogin,
    this.purchasedIdeas,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.banReason,
    this.bannedAt,
    this.isBanned,
    this.role,
    this.displayName,
    this.membership,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      isVerified: json['isVerified'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      wallet: json['wallet'] as int?,
      profileImage: json['profileImage'] as String?,
      isActive: json['isActive'] as bool?,
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      purchasedIdeas: json['purchasedIdeas'] as List<dynamic>?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
      banReason: json['banReason'] as String?,
      bannedAt: json['bannedAt'] != null ? DateTime.parse(json['bannedAt']) : null,
      isBanned: json['isBanned'] as bool?,
      role: json['role'] as String?,
      displayName: json['displayName'] as String?,
      membership: json['membership'] != null ? UserMembershipModel.fromJson(json['membership']) : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'phone': phone,
    'email': email,
    'username': username,
    'isVerified': isVerified,
    'isAdmin': isAdmin,
    'wallet': wallet,
    'profileImage': profileImage,
    'isActive': isActive,
    'lastLogin': lastLogin?.toIso8601String(),
    'purchasedIdeas': purchasedIdeas,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'banReason': banReason,
    'bannedAt': bannedAt?.toIso8601String(),
    'isBanned': isBanned,
    'role': role,
    'displayName': displayName,
    'membership': membership?.toJson(),
  };
}

enum Member {
  free('free'),
  premium('premium');

  final String value;
  const Member(this.value);

  factory Member.fromString(String? type) {
    switch (type) {
      case 'premium':
        return Member.premium;
      case 'free':
      default:
        return Member.free;
    }
  }

  String toJson() => value;
}

final class UserMembershipModel extends BaseModel {
  final Member? type;
  final DateTime? expiresAt;
  final DateTime? purchasedAt;

  UserMembershipModel({this.type, this.expiresAt, this.purchasedAt});

  factory UserMembershipModel.fromJson(Map<String, dynamic> json) {
    return UserMembershipModel(
      type: Member.fromString(json['type'] as String?),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      purchasedAt: json['purchasedAt'] != null ? DateTime.parse(json['purchasedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type?.toJson(),
    'expiresAt': expiresAt?.toIso8601String(),
    'purchasedAt': purchasedAt?.toIso8601String(),
  };
}

extension DateTimeExpiration on DateTime {
  int get daysUntilExpiration {
    final DateTime now = DateTime.now();
    final int difference = this.difference(now).inDays;
    return difference;
  }
}
