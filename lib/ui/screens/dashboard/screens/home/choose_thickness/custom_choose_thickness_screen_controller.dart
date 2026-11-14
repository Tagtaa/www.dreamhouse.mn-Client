import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_controller.dart';
import 'choose_thickness_screen_args.dart';

final class CustomChooseThicknessScreenController extends BaseScreenController<ChooseThicknessScreenArgs> {
  final Service<CalculationService> _calculationService;

  CustomChooseThicknessScreenController(
    super.args,
    this._calculationService,
  ) : onItemTap = args.onItemTap;

  Rx<List<ChooseThickness>> chooseThicknessLists = Rx<List<ChooseThickness>>(<ChooseThickness>[]);

  late final void Function(ChooseThickness selectedThicknessType)? onItemTap;

  final Rx<int> selectedIndex = Rx<int>(-1);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchCustomThickness();
  }

  Future<void> fetchCustomThickness() async {
    viewState.setBusy(true);
    await _calculationService().getChooseThickness().then(
      (Result<ChooseThicknessResponseModel, ApiException> result) {
        result.on(
          success: (ChooseThicknessResponseModel result) async {
            chooseThicknessLists(set: () => result.data?.thicknessOptions ?? <ChooseThickness>[]);
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  void selectItemIndex(int index) {
    selectedIndex(set: () => index);
  }
}
