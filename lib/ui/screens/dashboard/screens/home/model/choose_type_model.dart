import '../../../../../../core/models/calculation/choose_type_response_model.dart';

final class ChooseTypeModel {
  final String type;
  void Function(ChooseType)? onItemTap;

  ChooseTypeModel({
    required this.type,
    required this.onItemTap,
  });
}
