import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/models/rx.dart';
import '../../../../core/utils/extensions/size_extensions.dart';
import '../../../../core/utils/validation/form_validation.dart';
import '../../../components/widgets/gesture_detector.dart';
import '../../../components/widgets/multi_style_text.dart';
import '../../../components/widgets/obx.dart';
import '../../base_screen_view.dart';
import '../controller/auth_screen_controller.dart';
import '../model/auth_screen_args.dart';
import 'widget/bottom_button.dart';
import 'widget/login_header.dart';
import 'widget/number_pad.dart';
import '../../../components/widgets/textfields/custom_text_field.dart';

@RoutePage()
final class LoginPasswordScreenView extends BaseScreenView<AuthScreenController, AuthScreenArgs> {
  const LoginPasswordScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: true),
      );

  @override
  State<LoginPasswordScreenView> createState() => _LoginPasswordScreenViewState();
}

final class _LoginPasswordScreenViewState extends BaseScreenViewState<LoginPasswordScreenView, AuthScreenController, AuthScreenArgs> {
  @override
  Scaffold builder(BuildContext context, AuthScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isTablet = context.isTablet;

    Widget buildFormContent(bool isSmallScreen) {
      return Form(
        key: controller.formPasswordKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: switch (isSmallScreen) {
                true => const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal, vertical: AppSize.paddingLowest),
                false => const EdgeInsets.all(AppSize.paddingNormal),
              },
              child: Obx(
                controller.isResetPasswordScreen,
                builder: (BuildContext context, Rx<bool> isResetPasswordScreen, _) {
                  return switch (isResetPasswordScreen()) {
                    true => MultiStyleText(
                      firstText: TextConstants.loginResetPasswordTitleFirst,
                      secondText: TextConstants.loginPasswordTitleSecond,
                      firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                      secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                    ),
                    false => MultiStyleText(
                      firstText: TextConstants.loginPasswordTitleFirst,
                      secondText: TextConstants.loginPasswordTitleSecond,
                      firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                      secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                    ),
                  };
                },
              ),
            ),

            const SizedBox(height: AppSize.emptySizeLowest),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: Obx(
                controller.isResetPasswordScreen,
                builder: (BuildContext context, Rx<bool> isResetPasswordScreen, _) {
                  return switch (isResetPasswordScreen()) {
                    true => Text(
                      TextConstants.loginResetPasswordDescription,
                      style: AppTextStyles.labelSmall(color: AppColors.surface),
                    ),
                    false => Text(
                      TextConstants.loginPasswordDescription,
                      style: AppTextStyles.labelSmall(color: AppColors.surface),
                    ),
                  };
                },
              ),
            ),

            SizedBox(height: isSmallScreen ? AppSize.emptySizeLow : AppSize.emptySizeLow),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: PasswordTextField(
                key: const ValueKey<String>('password_field'),
                controller: controller.passwordController,
                hintText: TextConstants.loginPasswordHint,
                validator: FormValidators.validateCode,
              ),
            ),

            SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

            Expanded(
              child: CustomNumberPad(
                controller: controller.passwordController,
                maxNumberLength: AppSize.phoneCodeNumberMaxLimit,
              ),
            ),

            const SizedBox(height: AppSize.emptySize),
          ],
        ),
      );
    }

    Widget buildBottomSection(bool isSmallScreen, bool isTablet) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (controller.authState == AuthState.login) ...<Widget>[
              Obx(
                controller.isResetPasswordScreen,
                builder: (BuildContext context, Rx<bool> isResetPasswordScreen, _) {
                  return switch (isResetPasswordScreen()) {
                    true => const SizedBox(),
                    false => CustomGestureDetector(
                      onTap: controller.onTapForgotPassword,
                      child: Text(
                        TextConstants.resetPinCode,
                        style: AppTextStyles.titleLarge(color: AppColors.text),
                      ),
                    ),
                  };
                },
              ),

              SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),
            ],

            BottomButtonWidget(
              isSmallScreen: isSmallScreen,
              isTablet: isTablet,
              onTap: controller.onContinuePasswordPressed,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          LoginHeaderWidget(isTablet: isTablet),
          Expanded(
            child: buildFormContent(isSmallScreen),
          ),

          Container(
            child: buildBottomSection(isSmallScreen, isTablet),
          ),
        ],
      ),
    );
  }
}
