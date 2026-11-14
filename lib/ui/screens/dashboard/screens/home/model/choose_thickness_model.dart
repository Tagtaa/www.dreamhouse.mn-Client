import '../../../../../../core/models/calculation/choose_thickness_response_model.dart';

final class ChooseThicknessModel {
  void Function(ChooseThickness)? onItemTap;

  ChooseThicknessModel({
    required this.onItemTap,
  });
}
