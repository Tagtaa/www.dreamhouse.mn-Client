class IdeaPurchaseResponseModel {
  final bool success;
  final String message;
  final IdeaPurchaseData data;

  const IdeaPurchaseResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory IdeaPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return IdeaPurchaseResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: IdeaPurchaseData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class IdeaPurchaseData {
  final IdeaModel idea;
  final int remainingBalance;

  const IdeaPurchaseData({
    required this.idea,
    required this.remainingBalance,
  });

  factory IdeaPurchaseData.fromJson(Map<String, dynamic> json) {
    return IdeaPurchaseData(
      idea: IdeaModel.fromJson(json['idea'] as Map<String, dynamic>),
      remainingBalance: json['remainingBalance'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'idea': idea.toJson(),
    'remainingBalance': remainingBalance,
  };
}

class IdeaModel {
  final String id;
  final String title;
  final int purchasePrice;

  const IdeaModel({
    required this.id,
    required this.title,
    required this.purchasePrice,
  });

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      purchasePrice: json['purchasePrice'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '_id': id,
    'title': title,
    'purchasePrice': purchasePrice,
  };
}
