import '../../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../../core/init/app_locator.dart';
import '../../../../../../../core/models/calculation/calculation_create_response_model.dart';
import '../../../../../../../core/models/calculation/calculation_custom_model.dart';
import '../../../../../../../core/models/calculation/choose_shape_response_model.dart';
import '../../../../../../../core/models/calculation/choose_thickness_response_model.dart';
import '../../../../../../../core/models/calculation/choose_type_response_model.dart';
import '../../../../../../../core/models/calculation/door_window_model.dart';
import '../../../../../../../core/models/calculation/ing_calc_model.dart';
import '../../../../../../../core/models/materials/list/material_list_model.dart';
import '../../../../../../../core/models/result.dart';
import '../../../../../../../core/models/rx.dart';
import '../../../../../../../core/routing/app_navigation.dart';
import '../../../../../../../core/services/auth/auth_service.dart';
import '../../../../../../../core/services/calculation/calculation_service.dart';
import '../../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../../base_screen_controller.dart';
import 'calculation_screen_args.dart';

final class CalculationScreenController extends BaseScreenController<CalculationScreenArgs> {
  final Service<CalculationService> _calculationService;

  CalculationScreenController(
    super.args,
    this._calculationService,
  ) : selectedMaterialModel = args.selectedMaterialModel,
      selectedShapeModel = args.selectedShapeModel,
      selectedThicknessModel = args.selectedThicknessModel,
      selectedTypeModel = args.selectedTypeModel,
      calculationCustomModel = args.calculationCustomModel,
      priceOneBlock = args.priceOneBlock,
      totalVolume = args.volume,
      doorList = args.doorList ?? <DoorWindowModel>[],
      windowList = args.windowList ?? <DoorWindowModel>[],
      totalArea = args.area;

  ChooseType? selectedTypeModel;
  ChooseShape? selectedShapeModel;
  MaterialItem? selectedMaterialModel;
  ChooseThickness? selectedThicknessModel;
  CalculationCustomModel? calculationCustomModel;
  Rx<List<IngCalcModel>> ingCalcModelList = Rx<List<IngCalcModel>>(<IngCalcModel>[]);

  List<DoorWindowModel> doorList = <DoorWindowModel>[];
  List<DoorWindowModel> windowList = <DoorWindowModel>[];
  Rx<List<Ingredient>> ingredientsList = Rx<List<Ingredient>>(<Ingredient>[]);

  double? totalVolume;
  double? totalArea;
  double? priceOneBlock;
  Rx<int> materialItemCount = Rx<int>(1);
  Rx<double> totalPrice = Rx<double>(0.0);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    calculationItemCount();
    newCalculateIngredientsPrice();
  }

  void calculationItemCount() {
    // Custom blocks: the estimation screen stores sizes already in metres and
    // the user's own price; a selected material stores sizes in cm.
    final CalculationCustomModel? custom = calculationCustomModel;
    final double materialWidth = custom != null ? (custom.blockWidth ?? 0.01) : _cmToM3(selectedMaterialModel?.width?.toDouble() ?? 1.0);
    final double materialLength = custom != null ? (custom.blockLength ?? 0.01) : _cmToM3(selectedMaterialModel?.length?.toDouble() ?? 1.0);
    final double materialHeight = custom != null ? (custom.blockHeight ?? 0.01) : _cmToM3(selectedMaterialModel?.height?.toDouble() ?? 1.0);
    final double materialPrice = (custom != null ? (custom.price ?? priceOneBlock) : selectedMaterialModel?.price?.toDouble()) ?? 1.0;

    if (totalArea != null) {
      final double materialArea = materialWidth * materialLength;
      final double needMaterial = totalArea! / materialArea;
      materialItemCount(set: () => needMaterial.ceil());
      totalPrice(set: () => materialItemCount.value * materialPrice);
    }
    if (totalVolume != null) {
      final double materialVolume = materialWidth * materialLength * materialHeight;
      final double needMaterial = totalVolume! / materialVolume;
      materialItemCount(set: () => needMaterial.ceil());
      totalPrice(set: () => materialItemCount.value * materialPrice);
    }
  }

  void newCalculateIngredientsPrice() {
    // Each material has its own ingredients
    final List<Ingredient>? ingredients = selectedMaterialModel?.calculationIngredients;

    if (ingredients != null) {
      ingredientsList(set: () => ingredients);

      if (totalArea != null) {
        for (final Ingredient ing in ingredients) {
          if (ing.unit == 'm2') {
            if (ing.pricePerM2 != null && ing.percentValue != null) {
              final double amount = totalArea! * (ing.percentValue! / 100);
              final double price = ing.pricePerM2!.toDouble() * amount;
              totalPrice(set: () => totalPrice.value + ing.pricePerM2!.toDouble() * amount);

              final IngCalcModel ingModel = IngCalcModel(name: ing.name ?? '', amount: amount, unit: 'm2', price: price);
              ingCalcModelList(
                set: () => <IngCalcModel>[
                  ...ingCalcModelList.value,
                  ...<IngCalcModel>[ingModel],
                ],
              );
            }
          }
        }
      } else if (totalVolume != null) {
        for (final Ingredient ing in ingredients) {
          if (ing.unit == 'm3') {
            if (ing.pricePerM3 != null && ing.percentValue != null) {
              final double amount = totalVolume! * (ing.percentValue! / 100);
              final double price = ing.pricePerM3!.toDouble() * amount;
              totalPrice(set: () => totalPrice.value + ing.pricePerM3!.toDouble() * amount);

              final IngCalcModel ingModel = IngCalcModel(name: ing.name ?? '', amount: amount, unit: 'm3', price: price);
              ingCalcModelList(
                set: () => <IngCalcModel>[
                  ...ingCalcModelList.value,
                  ...<IngCalcModel>[ingModel],
                ],
              );
            }
          }
          //  else if (ing.unit == 'kg') {
          //   if (ing.priceForPer1Percent != null && ing.percentValue != null) {
          //     final double currentValue = totalVolume! / ing.percentValue!;
          //     final double currentPrice = currentValue * ing.priceForPer1Percent!;
          //     totalPrice(set: () => totalPrice.value + currentPrice);
          //   }
          //}
        }
      }
    }
  }

  double _cmToM3(double value) => value / 100.0;

  Future<void> onSave() async {
    if (!ServiceLocator.get<AuthService>().isMember) {
      AppNavigation.gotoMemberShipExpiredRoute(context());

      return;
    }

    viewState.setBusy(true);
    await _calculationService()
        .createCalculation(
          selectedTypeModel: selectedTypeModel,
          selectedShapeModel: selectedShapeModel,
          selectedMaterialModel: selectedMaterialModel,
          selectedThicknessModel: selectedThicknessModel,
          calculationCustomModel: calculationCustomModel,
          totalPrice: totalPrice.value,
          totalVolume: totalVolume,
          totalArea: totalArea,
          materialItemCount: materialItemCount.value,
          doorList: doorList,
          windowList: windowList,
          ingCalcModelList: ingCalcModelList.value,
        )
        .then(
          (Result<CalculationCreateResponseModel, ApiException> result) {
            result.on(
              success: (CalculationCreateResponseModel result) async {
                await showAlertNotification(context(), message: TextConstants.calculationCreatedSuccessfully, icon: AppImages.success_alert());
                await AppNavigation.popRoute(context());
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
