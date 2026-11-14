import '../../base_screen_args.dart';
import '../controller/auth_screen_controller.dart';

final class AuthScreenArgs extends BaseScreenArgs {
  final AuthState authState;
  final String? phone;
  final String? password;

  AuthScreenArgs({
    this.authState = AuthState.login,
    this.phone,
    this.password,
  });
}
