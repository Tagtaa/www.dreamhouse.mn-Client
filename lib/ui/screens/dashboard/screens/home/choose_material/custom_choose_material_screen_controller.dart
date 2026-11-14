import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/models/rx.dart';
import '../../../../../../core/services/material/material_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_controller.dart' show Service, BaseScreenController;
import 'choose_material_screen_args.dart';

final class CustomChooseMaterialScreenController extends BaseScreenController<ChooseMaterialScreenArgs> {
  final Service<MaterialService> _materialService;

  CustomChooseMaterialScreenController(
    super.args,
    this._materialService,
  ) : material = args.material,
      onItemTap = args.onItemTap;

  Rx<List<MaterialItem>> chooseMaterialLists = Rx<List<MaterialItem>>(<MaterialItem>[]);
  late final String material;
  final Rx<int> selectedIndex = Rx<int>(-1);
  late final void Function(MaterialItem selectedChooseMaterial)? onItemTap;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    fetchCustomMaterials();
  }

  Future<void> fetchCustomMaterials() async {
    viewState.setBusy(true);
    await _materialService().getMaterials(parentCategory: material, page: 1, limit: 20).then(
      (Result<MaterialsResponseModel, ApiException> result) {
        result.on(
          success: (MaterialsResponseModel result) async {
            chooseMaterialLists(set: () => result.data.materials);
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
