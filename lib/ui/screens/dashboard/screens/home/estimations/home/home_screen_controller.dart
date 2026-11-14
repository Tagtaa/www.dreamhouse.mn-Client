import '../../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../../core/models/calculation/calculation_type_response_model.dart';
import '../../../../../../../core/models/result.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../core/services/auth/auth_service.dart';
import '../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../../base_screen_args.dart';
import '../../../../../base_screen_controller.dart';

final class HomeScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<CalculationService> _calculationService;
  final Service<AuthService> _authService;

  HomeScreenController(
    super.args,
    this._calculationService,
    this._authService,
  );

  Rx<List<CalculationType>> typeList = Rx<List<CalculationType>>(<CalculationType>[]);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    await checkHealth();
  }

  Future<void> fetchTypes() async {
    viewState.setBusy(true);
    await _calculationService().getTypes().then(
      (Result<CalculationTypeResponseModel, ApiException> result) {
        result.on(
          success: (CalculationTypeResponseModel result) async {
            typeList(set: () => result.data?.types ?? <CalculationType>[]);
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  Future<void> checkHealth() async {
    await _authService().getHealth().then(
      (Result<bool, ApiException> result) {
        result.on(
          success: (_) {
            fetchTypes();
          },
          failure: (ApiException e) async {
            AppNavigation.gotoDevelopmentMode(context());
          },
        );
      },
    );
  }
}
