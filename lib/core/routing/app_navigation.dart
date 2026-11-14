import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../ui/screens/auth/model/auth_screen_args.dart';
import '../../ui/screens/base_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_material/choose_material_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_shapes/choose_shapes_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_thickness/choose_thickness_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_type/choose_type_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation/calculation_screen_args.dart';
import '../../ui/screens/dashboard/screens/idea/detail/idea_detail_screen_args.dart';
import '../../ui/screens/dashboard/screens/profile/profile_screen_args.dart';
import '../../ui/screens/dashboard/screens/profile/recharge_screen_args.dart';
import '../../ui/screens/image_picker/image_picker_screen_args.dart';
import '../models/auth/api/subscription/subscription_response_model.dart';
import 'app_router.dart';

abstract final class AppNavigation {
  static final AppRouter _router = AppRouter(navigatorKey: rootNavigatorKey);
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final GlobalKey<NavigatorState> ideaNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'idea');
  static final GlobalKey<NavigatorState> materialNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'material');
  static final GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  static RouterConfig<Object> get routerConfig => _router.routerConfig;

  static void unfocus([UnfocusDisposition disposition = UnfocusDisposition.scope]) {
    FocusManager.instance.primaryFocus?.unfocus(
      disposition: disposition,
    );
  }

  static Future<void> popRoute<T>(BuildContext? context, [T? result]) async {
    if (context != null && context.mounted) {
      await context.maybePop<T>(result);
    }
    //await context?.popRoute<T>(result);
  }

  static void goToSplashScreen(BuildContext? context) {
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[SplashScreenRoute(args: const DefaultScreenArgs())],
      updateExistingRoutes: false,
    );
  }

  static void goToDashboardScreen(BuildContext? context) {
    // context?.router.replaceAll(<PageRouteInfo>[const DashboardScreenRoute()]);
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[DashboardScreenRoute()],
      updateExistingRoutes: false,
    );
  }

  static void goToOnboardingScreen(BuildContext? context) {
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[const OnboardingScreenRoute()],
      updateExistingRoutes: false,
    );
  }

  static void gotoEstimationRoute(BuildContext? context, {required PageRouteInfo route}) {
    context?.pushRoute(route);
  }

  static void gotoChooseTypeRoute(BuildContext? context, {required ChooseTypeScreenArgs args}) {
    context?.router.navigate(CustomChooseTypeScreenRoute(args: args));
  }

  static void gotoMemberShipExpiredRoute(BuildContext? context) {
    context?.router.navigate(const MembershipExpiredRoute());
  }

  static void gotoDevelopmentMode(BuildContext? context) {
    context?.router.navigate(const DevelopmentModeScreenRoute());
  }

  static void gotoChooseMaterialRoute(BuildContext? context, {required ChooseMaterialScreenArgs args}) {
    context?.router.navigate(CustomChooseMaterialScreenRoute(args: args));
  }

  static void gotoChooseThicknessRoute(BuildContext? context, {required ChooseThicknessScreenArgs args}) {
    context?.router.navigate(CustomChooseThicknessScreenRoute(args: args));
  }

  static void gotoChooseShapeRoute(BuildContext? context, {required ChooseShapesScreenArgs args}) {
    context?.router.navigate(CustomChooseShapesScreenRoute(args: args));
  }

  static void gotoCalculationRoute(BuildContext? context, {CalculationScreenArgs? args}) {
    if (args != null) {
      context?.pushRoute(CalculationScreenRoute(args: args));
    }
  }

  static void gotoProfileRoute(BuildContext? context, {required ProfileScreenArgs args}) {
    context?.pushRoute(ProfileScreenRoute(args: args));
  }

  static void gotoCalculationHistoryRoute(BuildContext? context) {
    context?.pushRoute(CalculationHistoryScreenRoute());
  }

  static void gotoPurchasedHistoryRoute(BuildContext? context) {
    context?.pushRoute(PurchasedHistoryScreenRoute());
  }

  static void goToImagePicker(BuildContext? context, {required ImagePickerScreenArgs args}) {
    context?.pushRoute(ImagePickerScreenRoute(args: args));
  }

  static void gotoIdeaDetailRoute(BuildContext? context, {required String ideaId}) {
    context?.pushRoute(IdeaDetailScreenRoute(args: IdeaDetailScreenArgs(ideaId: ideaId)));
  }

  static void gotoRechargeRoute(BuildContext? context, {required RechargeScreenArgs args}) {
    context?.pushRoute(RechargeScreenRoute(args: args));
  }

  static void gotoPurchaseMembershipRoute(BuildContext? context, {required int balance, required SubscriptionsResponseModel? subscriptionsModel, required RechargeScreenArgs rechargeScreenArgs}) {
    context?.pushRoute(
      PurchaseMembershipScreenRoute(
        balance: balance,
        subscriptionModel: subscriptionsModel,
        rechargeScreenArgs: rechargeScreenArgs,
      ),
    );
  }

  static void gotoProfileItemRoute(BuildContext? context, {required PageRouteInfo route, void Function()? onThen}) {
    context?.pushRoute(route).then((_) => onThen?.call());
  }

  static void gotoItemRoute(BuildContext? context, {required PageRouteInfo route}) {
    context?.pushRoute(route);
  }

  static void gotoLoginOptionRoute(BuildContext? context) {
    //context?.pushRoute(LoginOptionScreenRoute());

    // (context ?? rootNavigatorKey.currentContext)?.router.replace(const LoginOptionScreenRoute());
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[const LoginOptionScreenRoute()],
      updateExistingRoutes: false,
    );
  }

  static void gotoLoginPasswordRoute(BuildContext? context, {required AuthScreenArgs args}) {
    context?.pushRoute(LoginPasswordScreenRoute(args: args));
  }

  static void gotoLoginPhoneRoute(BuildContext? context, {required AuthScreenArgs args}) {
    context?.pushRoute(LoginPhoneNumberScreenRoute(args: args));
  }

  static void gotoLoginUsernameRoute(BuildContext? context, {required AuthScreenArgs args}) {
    context?.pushRoute(LoginUserNameScreenRoute(args: args));
  }

  static void gotoChatbotRoute(BuildContext? context) {
    context?.pushRoute(ChatbotScreenRoute());
  }

  static void gotoChatbotAnonymousRoute(BuildContext? context) {
    context?.pushRoute(ChatbotAnonymousScreenRoute());
  }
}
