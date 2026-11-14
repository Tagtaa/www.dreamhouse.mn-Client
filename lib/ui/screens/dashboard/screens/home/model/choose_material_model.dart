import '../../../../../../core/models/materials/list/material_list_model.dart';

final class ChooseMaterialModel {
  final String type;
  void Function(MaterialItem)? onItemTap;

  ChooseMaterialModel({
    required this.type,
    required this.onItemTap,
  });
}
