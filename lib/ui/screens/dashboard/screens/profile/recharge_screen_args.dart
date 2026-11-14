import '../../../../../../core/models/auth/api/me/user_model.dart';
import '../../../base_screen_args.dart';

final class RechargeScreenArgs extends BaseScreenArgs {
  final UserModel? user;

  const RechargeScreenArgs({this.user});
}
