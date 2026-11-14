import '../../../base_screen_args.dart';

final class ProfileScreenArgs extends BaseScreenArgs {
  final bool isMembershipExpired;

  const ProfileScreenArgs({
    this.isMembershipExpired = false,
  });
}
