import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/auth/login/login_option_screen_view.dart';
import '../../ui/screens/auth/login/login_password_screen_view.dart';
import '../../ui/screens/auth/login/login_phone_number_screen_view.dart';
import '../../ui/screens/auth/login/login_username_screen_view.dart';
import '../../ui/screens/auth/model/auth_screen_args.dart';
import '../../ui/screens/base_screen_args.dart';
import '../../ui/screens/chatbot/chatbot_screen_args.dart';
import '../../ui/screens/chatbot/chatbot_screen_view.dart';
import '../../ui/screens/chatbot_anonymous/chatbot_anonymous_screen_args.dart';
import '../../ui/screens/chatbot_anonymous/chatbot_anonymous_screen_view.dart';
import '../../ui/screens/dashboard/dashboard_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/choose_material/choose_material_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_shapes/choose_shapes_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_shapes/custom_choose_shapes_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/choose_thickness/choose_thickness_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/choose_thickness/custom_choose_thickness_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/choose_type/choose_type_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation/calculation_screen_args.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation_history/calculation_history_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/floor_tiles/estimation/floor_tiles_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/fundament/estimation/fundament_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/inner_wall/estimation/inner_wall_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/roof/estimation/roof_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/underfloor/estimation/underfloor_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/wall/estimation/wall_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/wall_decoration/estimation/wall_decoration_estimation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/home/home_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/estimations/calculation/calculation_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/choose_material/custom_choose_material_screen_view.dart';
import '../../ui/screens/dashboard/screens/home/choose_type/custom_choose_type_screen_view.dart';
import '../../ui/screens/dashboard/screens/idea/detail/idea_detail_screen_view.dart';
import '../../ui/screens/dashboard/screens/idea/detail/idea_detail_screen_args.dart';
import '../../ui/screens/dashboard/screens/idea/list/idea_list_screen_view.dart';
import '../../ui/screens/dashboard/screens/idea/purchased/purchased_history_screen_view.dart';
import '../../ui/screens/dashboard/screens/material/list/material_list_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/contact_us_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/edit/edit_profile_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/membership_expired_view.dart';
import '../../ui/screens/dashboard/screens/profile/privacy_policy_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/profile_screen_args.dart';
import '../../ui/screens/dashboard/screens/profile/profile_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/purchase_membership_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/recharge_screen_args.dart';
import '../../ui/screens/dashboard/screens/profile/recharge_screen_view.dart';
import '../../ui/screens/dashboard/screens/profile/terms_and_conditions_screen_view.dart';
import '../../ui/screens/development_mode/development_mode_screen_view.dart';
import '../../ui/screens/image_picker/image_picker_screen_args.dart';
import '../../ui/screens/image_picker/image_picker_screen_view.dart';
import '../../ui/screens/onboarding/onboarding_screen_view.dart';
import '../../ui/screens/splash/splash_screen_view.dart';
import '../models/auth/api/subscription/subscription_response_model.dart';
import 'app_navigation.dart';
import 'guards/auth_guard.dart';
import 'observers/navigation_observer.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends RootStackRouter implements AutoRouteGuard {
  AppRouter({
    required super.navigatorKey,
  });

  @override
  final List<AutoRoute> routes = <AutoRoute>[
    RedirectRoute(path: '/', redirectTo: '/splash'),
    AutoRoute(
      path: '/splash',
      page: SplashScreenRoute.page,
      fullscreenDialog: true,
      type: RouteType.custom(
        transitionsBuilder: TransitionsBuilders.noTransition,
      ),
    ),

    //AutoRoute(path: '/unknown', page: UnknownScreenRoute.page, fullscreenDialog: true),
    AutoRoute(
      path: '/login-option',
      page: LoginOptionScreenRoute.page,
      fullscreenDialog: true,
      // guards: <AutoRouteGuard>[
      //   AuthGuard(),
      // ],
    ),
    AutoRoute(path: '/login-password', page: LoginPasswordScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/login-phone-number', page: LoginPhoneNumberScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/login-username', page: LoginUserNameScreenRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/wall-estimation', page: WallEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/fundament-estimation', page: FundamentEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/roof-estimation', page: RoofEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/inner-wall-estimation', page: InnerWallEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/floor-estimation', page: UnderfloorEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/floor-tiles-estimation', page: FloorTilesEstimationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/wall-decoration-estimation', page: WallDecorationEstimationScreenRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/custom-choose-material', page: CustomChooseMaterialScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/custom-choose-type', page: CustomChooseTypeScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/custom-choose-shape', page: CustomChooseShapesScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/custom-choose-thickness', page: CustomChooseThicknessScreenRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/development-mode', page: DevelopmentModeScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/onboarding', page: OnboardingScreenRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/profile', page: ProfileScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/edit-profile', page: EditProfileScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/calculation-history', page: CalculationHistoryScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/purchased-history', page: PurchasedHistoryScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/contact-us', page: ContactUsScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/terms-and-conditions', page: TermsAndConditionsScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/privacy-policy', page: PrivacyPolicyRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/calculation', page: CalculationScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/purchase-membership', page: PurchaseMembershipScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/recharge', page: RechargeScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/membership-expired', page: MembershipExpiredRoute.page, fullscreenDialog: true),

    AutoRoute(path: '/idea-detail', page: IdeaDetailScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/image-picker', page: ImagePickerScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/chatbot', page: ChatbotScreenRoute.page, fullscreenDialog: true),
    AutoRoute(path: '/chatbot-anonymous', page: ChatbotAnonymousScreenRoute.page, fullscreenDialog: true),

    AutoRoute(
      path: '/dashboard',
      page: DashboardScreenRoute.page,
      fullscreenDialog: true,
      guards: <AutoRouteGuard>[
        AuthGuard(),
      ],
      children: <AutoRoute>[
        RedirectRoute(path: '', redirectTo: 'home-wrapper'),
        AutoRoute(
          path: 'home-wrapper',
          page: HomeScreenWrapperRoute.page,
          children: <AutoRoute>[
            RedirectRoute(path: '', redirectTo: 'home'),
            AutoRoute(path: 'home', page: HomeScreenRoute.page),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'idea-wrapper',
          page: IdeaScreenWrapperRoute.page,
          children: <AutoRoute>[
            RedirectRoute(path: '', redirectTo: 'idea'),
            AutoRoute(path: 'idea', page: IdeaListScreenRoute.page),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'material-wrapper',
          page: MaterialScreenWrapperRoute.page,
          children: <AutoRoute>[
            RedirectRoute(path: '', redirectTo: 'material'),
            AutoRoute(path: 'material', page: MaterialListScreenRoute.page),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        // AutoRoute(
        //   path: 'profile-wrapper',
        //   page: ProfileScreenWrapperRoute.page,
        //   fullscreenDialog: true,
        //   children: <AutoRoute>[
        //     RedirectRoute(path: '', redirectTo: 'profile'),
        //     AutoRoute(path: 'profile', page: ProfileScreenRoute.page, fullscreenDialog: true),
        //     RedirectRoute(path: '*', redirectTo: ''),
        //   ],
        // ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //    RedirectRoute(path: '*', redirectTo: '/unknown'),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  RouterConfig<UrlState> get routerConfig {
    return super.config(
      deepLinkBuilder: (PlatformDeepLink deepLink) {
        return DeepLink.defaultPath;
      },
      navigatorObservers: () {
        return <NavigatorObserver>[
          NavigationObserver(),
        ];
      },
    );
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    AppNavigation.unfocus();
    resolver.next();
  }
}
