import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/app_images.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/init/app_locator.dart';
import '../../../../../core/models/auth/api/me/user_model.dart';
import '../../../../../core/models/rx.dart';
import '../../../../../core/routing/app_navigation.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/services/auth/auth_service.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/buttons/custom_buttons.dart';
import '../../../../components/buttons/custom_icon_button.dart';
import '../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../components/widgets/custom_back_button.dart';
import '../../../../components/widgets/custom_image_network.dart';
import '../../../../components/widgets/gesture_detector.dart';
import '../../../../components/widgets/obx.dart';
import '../../../base_screen_view.dart';
import 'profile_screen_args.dart';
import 'profile_screen_controller.dart';
import 'recharge_screen_args.dart';

const double _thickness = 1.3;
const double _sizedBoxSize = 100.0;
const double _sizedBoxSmallScreenSize = 70.0;
const double _sizedBoxSizeLow = 40.0;
const double _sizedBoxSizeSmallScreenLow = 30;
const double _positionSize = 5.0;

@RoutePage()
final class ProfileScreenWrapperView extends AutoRouter {
  ProfileScreenWrapperView({super.key}) : super(navigatorKey: AppNavigation.profileNavigatorKey);
}

@RoutePage()
final class ProfileScreenView extends BaseScreenView<ProfileScreenController, ProfileScreenArgs> {
  const ProfileScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: true),
      );

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

final class _ProfileScreenViewState extends BaseScreenViewState<ProfileScreenView, ProfileScreenController, ProfileScreenArgs> {
  @override
  Scaffold builder(BuildContext context, ProfileScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: Obx(
        controller.user,
        builder: (BuildContext context, Rxn<UserModel> user, Widget? child) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(AppSize.paddingNormal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: isSmallScreen ? AppSize.emptySize : AppSize.emptySizeHigh),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: CustomBackButton(),
                        ),
                        Expanded(
                          child: Text(
                            TextConstants.profile,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.labelMedium(),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              color: AppColors.onPrimary,
                              width: isSmallScreen ? _sizedBoxSmallScreenSize : _sizedBoxSize,
                              height: isSmallScreen ? _sizedBoxSmallScreenSize : _sizedBoxSize,
                              child: switch (user.value?.profileImage != null && user.value!.profileImage!.isNotEmpty) {
                                true => CustomImageNetwork(user.value!.profileImage!),
                                false => const Icon(
                                  Icons.person,
                                  size: AppSize.iconSizeNormal,
                                  color: AppColors.onTertiary,
                                ),
                              },
                            ),
                          ),

                          Positioned(
                            bottom: -_positionSize,
                            right: -_positionSize,
                            child: CustomIconButton(
                              icon: AppIcons.pencil(
                                size: isSmallScreen ? AppSize.iconSizeLowest : AppSize.icon,
                                color: AppColors.buttonText,
                                applyColorFilter: true,
                              ),
                              size: isSmallScreen ? _sizedBoxSizeSmallScreenLow : _sizedBoxSizeLow,
                              backgroundColor: AppColors.secondary,
                              onTap: () => AppNavigation.gotoProfileItemRoute(
                                context,
                                route: EditProfileScreenRoute(),
                                onThen: () => controller.resetUser(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    Text(
                      '${user.value?.username}',
                      style: AppTextStyles.titleMedium(color: AppColors.onSurface, fontSize: AppSize.bodyFontSize),
                    ),
                    Text(
                      '${user.value?.phone}',
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.inverseSurface,
                        fontSize: AppSize.captionFontSize,
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        infoContainer('${user.value?.membership?.expiresAt?.daysUntilExpiration ?? '0'}', TextConstants.expireDay, isSmallScreen: isSmallScreen),
                        const SizedBox(width: AppSize.emptySizeLow),
                        infoContainer('${user.value?.wallet}', TextConstants.yourWallet, isSmallScreen: isSmallScreen),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: AppButton.customPrimarySmall(
                            text: TextConstants.reChargeWallet,
                            backgroundColor: AppColors.secondary,
                            radius: AppSize.radiusHighest,
                            isSmallScreen: isSmallScreen,
                            onTap: () => AppNavigation.gotoRechargeRoute(
                              context,
                              args: RechargeScreenArgs(
                                user: controller.user.value,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.emptySizeLow),
                        Expanded(
                          child: AppButton.customPrimarySmall(
                            text: TextConstants.purchase,
                            radius: AppSize.radiusHighest,
                            isSmallScreen: isSmallScreen,
                            onTap: () => AppNavigation.gotoPurchaseMembershipRoute(
                              context,
                              balance: user.value?.wallet ?? 0,
                              subscriptionsModel: controller.subscriptionModel.value,
                              rechargeScreenArgs: RechargeScreenArgs(user: controller.user.value),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(AppSize.paddingZero),
                        separatorBuilder: (BuildContext context, int index) => const Divider(
                          height: AppSize.emptySizeLow,
                          thickness: _thickness,
                          color: AppColors.borderColor,
                        ),
                        itemCount: ProfileItem.profileItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ProfileItem item = ProfileItem.profileItems[index];
                          return CustomGestureDetector(
                            onTap: () async {
                              if (item.isOnlyText) {
                                //AppNavigation.gotoLoginOptionRoute(context);
                                await showAlertNotification(
                                  context,
                                  message: TextConstants.logoutConfirmationMessage,
                                  icon: AppImages.warning_alert(),
                                  isAutoDismiss: false,
                                  onButtonPressed: () {
                                    ServiceLocator.get<AuthService>().logout().then((_) => AppNavigation.goToSplashScreen(context));
                                  },
                                );
                              } else {
                                AppNavigation.gotoProfileItemRoute(
                                  context,
                                  route: item.routePage,
                                  onThen: () {
                                    if (item.routePage == EditProfileScreenRoute()) {
                                      controller.resetUser();
                                    }
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: item.isOnlyText ? MainAxisAlignment.center : MainAxisAlignment.start,
                              children: <Widget>[
                                if (!item.isOnlyText) ...<Widget>[
                                  CustomIconButton(
                                    size: isSmallScreen ? AppSize.iconSizeNormal : AppSize.iconButtonSize,
                                    icon: item.icon(color: AppColors.buttonText, applyColorFilter: true),
                                    backgroundColor: AppColors.secondary,
                                  ),
                                  const SizedBox(width: AppSize.emptySize),
                                ],
                                Text(
                                  item.title,
                                  style: switch (item.isOnlyText) {
                                    true => AppTextStyles.titleLarge(color: AppColors.error),
                                    false => AppTextStyles.labelSmall(color: AppColors.onSurface),
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: AppSize.padding,
                bottom: AppSize.padding,
                child: CustomGestureDetector(
                  onTap: () => AppNavigation.gotoChatbotRoute(context),
                  child: AppIcons.chat(size: isSmallScreen ? AppSize.iconSizeNormal : AppSize.iconSizeHigh),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget infoContainer(String title, String body, {required bool isSmallScreen}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
            width: AppSize.one,
          ),
          borderRadius: BorderRadius.circular(AppSize.radiusLow),
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? AppSize.paddingLowest : AppSize.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyles.titleMedium(color: AppColors.onSurface, fontSize: AppSize.bodyFontSize),
              ),
              Text(
                body,
                style: AppTextStyles.captionText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem {
  final AppIcons icon;
  final String title;
  final PageRouteInfo routePage;
  final bool isOnlyText;

  ProfileItem({
    required this.icon,
    required this.title,
    required this.routePage,
    this.isOnlyText = false,
  });

  static final List<ProfileItem> profileItems = <ProfileItem>[
    ProfileItem(icon: AppIcons.edit_profile, title: TextConstants.editProfile, routePage: EditProfileScreenRoute()),
    ProfileItem(icon: AppIcons.document, title: TextConstants.calculationHistory, routePage: CalculationHistoryScreenRoute()),
    ProfileItem(icon: AppIcons.cart, title: TextConstants.purchasedItems, routePage: PurchasedHistoryScreenRoute()),
    ProfileItem(icon: AppIcons.email, title: TextConstants.contactUs, routePage: const ContactUsScreenRoute()),
    ProfileItem(icon: AppIcons.terms_and_conditions, title: TextConstants.termsAndConditions, routePage: const TermsAndConditionsScreenRoute()),
    ProfileItem(icon: AppIcons.folder_shield, title: TextConstants.privacyPolicy, routePage: const PrivacyPolicyRoute()),
    ProfileItem(icon: AppIcons.email, title: TextConstants.logout, routePage: const LoginOptionScreenRoute(), isOnlyText: true),
  ];
}
