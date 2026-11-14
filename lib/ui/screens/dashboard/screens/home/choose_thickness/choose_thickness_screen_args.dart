import '../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../base_screen_args.dart';

final class ChooseThicknessScreenArgs extends BaseScreenArgs {
  final void Function(ChooseThickness selectedThicknessType)? onItemTap;

  ChooseThicknessScreenArgs({
    this.onItemTap,
  });
}
