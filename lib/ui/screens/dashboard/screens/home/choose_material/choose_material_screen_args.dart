import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../base_screen_args.dart';

final class ChooseMaterialScreenArgs extends BaseScreenArgs {
  final String material;
  final void Function(MaterialItem selectedChooseMaterial)? onItemTap;

  ChooseMaterialScreenArgs({
    required this.material,
    this.onItemTap,
  });
}
