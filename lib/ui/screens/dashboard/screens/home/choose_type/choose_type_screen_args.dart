import '../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../base_screen_args.dart';

final class ChooseTypeScreenArgs extends BaseScreenArgs {
  final String type;
  final bool isLeftAlignText;
  final void Function(ChooseType selectedChooseType)? onItemTap;

  ChooseTypeScreenArgs({
    required this.type,
    this.isLeftAlignText = false,
    this.onItemTap,
  });
}
