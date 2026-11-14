import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_controller.dart';
import 'choose_type_screen_args.dart';

final class CustomChooseTypeScreenController extends BaseScreenController<ChooseTypeScreenArgs> {
  final Service<CalculationService> _calculationService;

  CustomChooseTypeScreenController(
    super.args,
    this._calculationService,
  ) : type = args.type,
      isLeftAlignText = args.isLeftAlignText,
      onItemTap = args.onItemTap;

  Rx<List<ChooseType>> chooseTypeLists = Rx<List<ChooseType>>(<ChooseType>[]);
  late final String type;
  late final bool isLeftAlignText;
  late final void Function(ChooseType selectedChooseType)? onItemTap;

  final Rx<int> selectedIndex = Rx<int>(-1);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchCustomTypes();
  }

  Future<void> fetchCustomTypes() async {
    viewState.setBusy(true);
    await _calculationService().getChooseTypes(type: type).then(
      (Result<ChooseTypesResponseModel, ApiException> result) {
        result.on(
          success: (ChooseTypesResponseModel result) async {
            chooseTypeLists(set: () => result.data.types);
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
