import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_controller.dart';
import 'choose_shapes_screen_args.dart';

final class CustomChooseShapesScreenController extends BaseScreenController<ChooseShapesScreenArgs> {
  final Service<CalculationService> _calculationService;

  CustomChooseShapesScreenController(
    super.args,
    this._calculationService,
  ) : onItemTap = args.onItemTap;

  Rx<List<ChooseShape>> chooseShapeLists = Rx<List<ChooseShape>>(<ChooseShape>[]);

  late final void Function(ChooseShape selectedShapeType)? onItemTap;

  final Rx<int> selectedIndex = Rx<int>(-1);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchCustomThickness();
  }

  Future<void> fetchCustomThickness() async {
    viewState.setBusy(true);
    await _calculationService().getChooseShapes().then(
      (Result<ChooseShapeResponseModel, ApiException> result) {
        result.on(
          success: (ChooseShapeResponseModel result) async {
            chooseShapeLists(set: () => result.data?.shapeOptions ?? <ChooseShape>[]);
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
