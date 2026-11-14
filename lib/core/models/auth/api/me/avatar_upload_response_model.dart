import '../../../base_model.dart';

final class AvatarUploadResponseModel extends BaseModel {
  final bool success;
  final String message;
  final String? imageUrl;
  final UserProfileModel? user;

  const AvatarUploadResponseModel._({
    required this.success,
    required this.message,
    this.imageUrl,
    this.user,
  });

  factory AvatarUploadResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;
    return AvatarUploadResponseModel._(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      imageUrl: data?['imageUrl'] as String?,
      user: data?['user'] != null ? UserProfileModel.fromJson(data!['user']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': <String, dynamic>{
        'imageUrl': imageUrl,
        'user': user?.toJson(),
      },
    };
  }
}

final class UserProfileModel extends BaseModel {
  final String id;
  final String username;
  final String email;
  final String? profileImage;

  const UserProfileModel._({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel._(
      id: json['_id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profileImage: json['profileImage'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'username': username,
      'email': email,
      'profileImage': profileImage,
    };
  }
}
