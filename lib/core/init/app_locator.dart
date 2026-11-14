import 'package:get_it/get_it.dart';

import '../../ui/screens/auth/controller/auth_screen_controller.dart';
import '../../ui/screens/auth/model/auth_screen_args.dart';
import '../../ui/screens/base_screen_args.dart';
import '../../ui/screens/base_screen_controller.dart';
import '../../ui/screens/dashboard/dashboard_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/choose_material/choose_material_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_material/custom_choose_material_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/choose_shapes/choose_shapes_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_shapes/custom_choose_shapes_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/choose_thickness/choose_thickness_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_thickness/custom_choose_thickness_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/choose_type/choose_type_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_type/custom_choose_type_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation/calculation_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation/calculation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation_history/calculation_history_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/floor_tiles/estimation/floor_tiles_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/fundament/estimation/fundament_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/home/home_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/inner_wall/estimation/inner_wall_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/roof/estimation/roof_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/underfloor/estimation/underfloor_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/wall/estimation/wall_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/home/estimations/wall_decoration/estimation/wall_decoration_estimation_screen_controller.dart';
import '../../ui/screens/dashboard/screens/idea/detail/idea_detail_screen_controller.dart';
import '../../ui/screens/dashboard/screens/idea/detail/idea_detail_screen_args.dart';
import '../../ui/screens/dashboard/screens/idea/list/idea_list_screen_controller.dart';
import '../../ui/screens/dashboard/screens/idea/purchased/purchased_history_screen_controller.dart';
import '../../ui/screens/dashboard/screens/material/list/material_list_screen_controller.dart';
import '../../ui/screens/dashboard/screens/profile/edit/edit_profile_screen_controller.dart';
import '../../ui/screens/dashboard/screens/profile/profile_screen_args.dart';
import '../../ui/screens/dashboard/screens/profile/profile_screen_controller.dart';
import '../../ui/screens/image_picker/image_picker_screen_args.dart';
import '../../ui/screens/image_picker/image_picker_screen_controller.dart';
import '../../ui/screens/splash/splash_screen_controller.dart';
import '../services/api/api_service.dart';
import '../services/app/app_service.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/message/anonymous_message_service.dart';
import '../services/auth/message/message_service.dart';
import '../services/base_service.dart';
import '../services/calculation/calculation_service.dart';
import '../services/config/config_service.dart';
import '../services/config/remote_config_service.dart';
import '../services/idea/idea_service.dart';
import '../services/local_storage/local_storage_service.dart';
import '../services/material/material_service.dart';
import 'init_config.dart';

abstract final class AppLocator {
  static Future<void> initControllers() async {
    await ControllerLocator._init();
  }

  static Future<void> initServices() async {
    await ServiceLocator._init();
  }
}

abstract final class ControllerLocator {
  static final GetIt _locator = GetIt.asNewInstance();
  static final Map<String, dynamic> _controllers = <String, dynamic>{};

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _controllers.clear();
    _register();
  }

  static void _register() {
    void registerController<C extends BaseScreenController<A>, A extends BaseScreenArgs>(
      C Function(A args) factoryFunc, {
      String? instanceName,
    }) {
      _locator.registerFactoryParam<C, A, void>(
        (A args, _) => factoryFunc(args),
        instanceName: instanceName,
      );
    }

    registerController<DashboardScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => DashboardScreenController(
        args,
      ),
    );

    registerController<HomeScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => HomeScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
        () => ServiceLocator.get<AuthService>(),
      ),
    );

    registerController<CalculationHistoryScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => CalculationHistoryScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<CustomChooseTypeScreenController, ChooseTypeScreenArgs>(
      (ChooseTypeScreenArgs args) => CustomChooseTypeScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<CustomChooseMaterialScreenController, ChooseMaterialScreenArgs>(
      (ChooseMaterialScreenArgs args) => CustomChooseMaterialScreenController(
        args,
        () => ServiceLocator.get<MaterialService>(),
      ),
    );

    registerController<CustomChooseThicknessScreenController, ChooseThicknessScreenArgs>(
      (ChooseThicknessScreenArgs args) => CustomChooseThicknessScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<CustomChooseShapesScreenController, ChooseShapesScreenArgs>(
      (ChooseShapesScreenArgs args) => CustomChooseShapesScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<AuthScreenController, AuthScreenArgs>(
      (AuthScreenArgs args) => AuthScreenController(
        args,
        () => ServiceLocator.get<AuthService>(),
      ),
    );

    registerController<MaterialListScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => MaterialListScreenController(
        args,
        () => ServiceLocator.get<MaterialService>(),
      ),
    );

    registerController<IdeaListScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => IdeaListScreenController(
        args,
        () => ServiceLocator.get<IdeaService>(),
      ),
    );

    registerController<PurchasedHistoryScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => PurchasedHistoryScreenController(
        args,
        () => ServiceLocator.get<IdeaService>(),
      ),
    );

    registerController<IdeaDetailScreenController, IdeaDetailScreenArgs>(
      (IdeaDetailScreenArgs args) => IdeaDetailScreenController(
        args,
        () => ServiceLocator.get<IdeaService>(),
      ),
    );

    registerController<WallDecorationEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => WallDecorationEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<WallEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => WallEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<UnderfloorEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => UnderfloorEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<RoofEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => RoofEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<InnerWallEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => InnerWallEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<FundamentEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => FundamentEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<FloorTilesEstimationScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => FloorTilesEstimationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<CalculationScreenController, CalculationScreenArgs>(
      (CalculationScreenArgs args) => CalculationScreenController(
        args,
        () => ServiceLocator.get<CalculationService>(),
      ),
    );

    registerController<SplashScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => SplashScreenController(args),
    );

    registerController<EditProfileScreenController, DefaultScreenArgs>(
      (DefaultScreenArgs args) => EditProfileScreenController(
        args,
        () => ServiceLocator.get<AuthService>(),
      ),
    );

    registerController<ImagePickerScreenController, ImagePickerScreenArgs>(
      (ImagePickerScreenArgs args) => ImagePickerScreenController(args),
    );

    registerController<ProfileScreenController, ProfileScreenArgs>(
      (ProfileScreenArgs args) => ProfileScreenController(
        args,
        () => ServiceLocator.get<AuthService>(),
      ),
    );
  }

  static String _getControllerKey<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    return '$hashCode-$C';
  }

  static C get<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    return _controllers[_getControllerKey<C>(hashCode)];
  }

  static C create<C extends BaseScreenController<A>, A extends BaseScreenArgs>(int hashCode, A args) {
    // Special handling for AuthScreenController to maintain singleton pattern
    // if (C == AuthScreenController) {
    //   final String key = _getControllerKey<C>(hashCode);
    //   return _controllers.putIfAbsent(
    //         key,
    //         () => AuthScreenController.getInstance(
    //           args as AuthScreenArgs,
    //           () => ServiceLocator.get<AuthService>(),
    //         ),
    //       )
    //       as C;
    // }

    return _controllers.putIfAbsent(
      _getControllerKey<C>(hashCode),
      () => _locator.get<C>(
        param1: args,
      ),
    );
  }

  static void dispose<C extends BaseScreenController<BaseScreenArgs>>(int hashCode) {
    get<C>(hashCode).onDispose();
    _controllers.remove(_getControllerKey<C>(hashCode));
  }
}

abstract final class ServiceLocator {
  static final GetIt _locator = GetIt.asNewInstance();

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _register();
    await _locator.allReady();
  }

  static void _register() {
    void registerService<S extends BaseService<S>>(
      S Function() getInstance, {
      String? instanceName,
      Iterable<Type>? dependsOn,
    }) {
      _locator.registerSingletonAsync<S>(
        () => getInstance().init(),
        instanceName: instanceName,
        dependsOn: dependsOn,
        dispose: (S instance) => instance.dispose(),
      );
    }

    // registerService<LocalizationService>(
    //   () => LocalizationService(),
    // );

    // registerService<FileService>(
    //   () => FileService(),
    // );

    registerService<LocalStorageService>(
      () => LocalStorageService(),
      //dependsOn: <Type>[LocalizationService],
    );

    // registerService<PermissionService>(
    //   () => PermissionService(),
    // );

    if (InitConfig.useFirebase) {
      registerService<ConfigService>(
        () => RemoteConfigService(),
      );
    }
    registerService<AppService>(
      () => AppService(
        () => ServiceLocator.get<ConfigService>(),
      ),
      dependsOn: <Type>[ConfigService],
    );

    registerService<MessageService>(
      () => MessageService(
        () => ServiceLocator.get<ApiService>(),
      ),
    );

    registerService<AnonymousMessageService>(
      () => AnonymousMessageService(
        () => ServiceLocator.get<ApiService>(),
      ),
    );

    registerService<MaterialService>(
      () => MaterialService(
        () => ServiceLocator.get<ApiService>(),
      ),
    );

    registerService<IdeaService>(
      () => IdeaService(
        () => ServiceLocator.get<ApiService>(),
      ),
    );

    registerService<CalculationService>(
      () => CalculationService(
        () => ServiceLocator.get<ApiService>(),
      ),
    );
    registerService<ApiService>(
      () => ApiService(
        () => ServiceLocator.get<AuthService>(),
      ),
      dependsOn: <Type>[LocalStorageService],
    );
    registerService<AuthService>(
      () => AuthService(
        () => ServiceLocator.get<ApiService>(),
        () => ServiceLocator.get<LocalStorageService>(),
      ),
      dependsOn: <Type>[LocalStorageService],
    );

    // registerService<ProfileService>(
    //   () => ProfileService(
    //     () => ServiceLocator.get<ApiService>(),
    //   ),
    //   dependsOn: <Type>[ApiService],
    // );
  }

  static T get<T extends Object>() => _locator.get<T>();
}
