import '../base_model.dart';

final class DoorWindowModel extends BaseModel {
  final double width;
  final double height;

  const DoorWindowModel({
    required this.width,
    required this.height,
  });

  factory DoorWindowModel.fromJson(Map<String, dynamic> json) {
    return DoorWindowModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'width': width,
    'height': height,
  };

  DoorWindowModel copyWith({
    double? width,
    double? height,
  }) {
    return DoorWindowModel(
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => <Object?>[width, height];
}
