final class PurchaseMemberShipResponseModel {
  final bool? success;
  final String? message;
  final PurchaseMemberShipDataModel? data;

  const PurchaseMemberShipResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory PurchaseMemberShipResponseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseMemberShipResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? PurchaseMemberShipDataModel.fromJson(
              json['data'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

final class PurchaseMemberShipDataModel {
  final String? transactionId;
  final String? plan;
  final String? subscriptionName;
  final int? price;
  final int? duration;
  final DateTime? expiresAt;
  final int? remainingBalance;
  final String? paymentMethod;

  const PurchaseMemberShipDataModel({
    this.transactionId,
    this.plan,
    this.subscriptionName,
    this.price,
    this.duration,
    this.expiresAt,
    this.remainingBalance,
    this.paymentMethod,
  });

  factory PurchaseMemberShipDataModel.fromJson(Map<String, dynamic> json) {
    return PurchaseMemberShipDataModel(
      transactionId: json['transactionId'] as String?,
      plan: json['plan'] as String?,
      subscriptionName: json['subscriptionName'] as String?,
      price: json['price'] as int?,
      duration: json['duration'] as int?,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      remainingBalance: json['remainingBalance'] as int?,
      paymentMethod: json['paymentMethod'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'plan': plan,
      'subscriptionName': subscriptionName,
      'price': price,
      'duration': duration,
      'expiresAt': expiresAt?.toIso8601String(),
      'remainingBalance': remainingBalance,
      'paymentMethod': paymentMethod,
    };
  }
}
