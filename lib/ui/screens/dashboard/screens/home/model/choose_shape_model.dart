import '../../../../../../core/models/calculation/choose_shape_response_model.dart';

final class ChooseShapeModel {
  void Function(ChooseShape)? onItemTap;

  ChooseShapeModel({
    required this.onItemTap,
  });
}
