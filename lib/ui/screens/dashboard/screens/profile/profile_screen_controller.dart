import '../../../../../../core/models/auth/api/me/user_model.dart';

import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../core/configs/constants/app_images.dart';
import '../../../../../core/exceptions/api_exception.dart';
import '../../../../../core/models/auth/api/subscription/subscription_response_model.dart';
import '../../../../../core/models/result.dart';
import '../../../../../core/models/rx.dart';
import '../../../../../core/routing/app_navigation.dart';
import '../../../../components/overlay/alert_notification_overlay.dart';
import '../../../base_screen_controller.dart';
import 'profile_screen_args.dart';
import 'recharge_screen_args.dart';

final class ProfileScreenController extends BaseScreenController<ProfileScreenArgs> {
  final Service<AuthService> _authService;

  ProfileScreenController(
    super.args,
    this._authService,
  ) : isMembershipExpired = args.isMembershipExpired;

  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<SubscriptionsResponseModel> subscriptionModel = Rxn<SubscriptionsResponseModel>();

  late final bool isMembershipExpired;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchUser();
    getSubscriptions();
  }

  void checkAndDirectToMembershipExpiredView() {
    if (isMembershipExpired) {
      AppNavigation.gotoPurchaseMembershipRoute(
        context(),
        balance: user.value?.wallet ?? 0,
        subscriptionsModel: subscriptionModel.value,
        rechargeScreenArgs: RechargeScreenArgs(user: user.value),
      );
    }
  }

  Future<void> fetchUser() async {
    await _authService().getCurrentUser();
    user(set: () => _authService().userResponse?.user);
    print(user.value);
  }

  Future<void> resetUser() async {
    user(set: () => null);
    await _authService().getCurrentUser();
    fetchUser();
  }

  Future<void> getSubscriptions() async {
    viewState.setBusy(true);

    await _authService().getSubscriptions().then(
      (Result<SubscriptionsResponseModel, ApiException> result) {
        result.on(
          success: (SubscriptionsResponseModel result) async {
            subscriptionModel(set: () => result);
            checkAndDirectToMembershipExpiredView();
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );

    viewState.setBusy(false);
  }
}
