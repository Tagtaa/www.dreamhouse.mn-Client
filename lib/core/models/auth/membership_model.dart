import '../base_model.dart';

final class MembershipModel extends BaseModel {
  final String type;
  final DateTime? expiresAt;
  final DateTime? purchasedAt;

  const MembershipModel._({
    required this.type,
    required this.expiresAt,
    required this.purchasedAt,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel._(
      type: json['type'] as String,
      expiresAt: (json['expiresAt'] != null) ? DateTime.parse(json['expiresAt'] as String) : null,
      purchasedAt: (json['purchasedAt'] != null) ? DateTime.parse(json['purchasedAt'] as String) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'expiresAt': expiresAt?.toIso8601String(),
      'purchasedAt': purchasedAt?.toIso8601String(),
    };
  }
}
