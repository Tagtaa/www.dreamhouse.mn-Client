import '../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../base_screen_args.dart';

final class ChooseShapesScreenArgs extends BaseScreenArgs {
  final void Function(ChooseShape selectedShapeType)? onItemTap;

  ChooseShapesScreenArgs({
    this.onItemTap,
  });
}
