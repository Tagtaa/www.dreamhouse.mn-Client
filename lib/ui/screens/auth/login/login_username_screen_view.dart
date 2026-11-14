import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/models/rx.dart';
import '../../../../core/utils/extensions/size_extensions.dart';
import '../../../../core/utils/validation/form_validation.dart';
import '../../../components/widgets/multi_style_text.dart';
import '../../../components/widgets/obx.dart';
import '../../../components/widgets/textfields/custom_text_field.dart';
import '../../base_screen_view.dart';
import '../controller/auth_screen_controller.dart';
import '../model/auth_screen_args.dart';
import 'widget/bottom_button.dart';
import 'widget/login_header.dart';

const double _borderSideWidth = 2.0;

@RoutePage()
final class LoginUserNameScreenView extends BaseScreenView<AuthScreenController, AuthScreenArgs> {
  const LoginUserNameScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: true),
      );

  @override
  State<LoginUserNameScreenView> createState() => _LoginUserNameScreenViewState();
}

final class _LoginUserNameScreenViewState extends BaseScreenViewState<LoginUserNameScreenView, AuthScreenController, AuthScreenArgs> {
  @override
  Scaffold builder(BuildContext context, AuthScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isTablet = context.isTablet;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    Widget buildFormContent(bool isSmallScreen) {
      return Form(
        key: controller.formUsernameKey,
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MultiStyleText(
                firstText: TextConstants.usernameFormTitleFirstText,
                secondText: TextConstants.usernameFormTitleSecondText,
                firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
              ),

              const SizedBox(height: AppSize.emptySizeLowest),

              Text(
                TextConstants.usernameFormDescription,
                style: AppTextStyles.labelSmall(color: AppColors.surface),
              ),

              const SizedBox(height: AppSize.emptySizeHigh),

              NameTextField(
                key: const ValueKey<String>('user_field'),
                hintText: TextConstants.usernameFormHintText,
                controller: controller.usernameController,
                validator: FormValidators.validateUsername,
              ),

              const SizedBox(height: AppSize.emptySizeLow),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: controller.acceptTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        controller.acceptTerms = value ?? false;
                      });
                    },
                    side: const BorderSide(
                      color: AppColors.primary,
                      width: _borderSideWidth,
                    ),
                  ),
                  Flexible(
                    child: MultiStyleText(
                      firstText: TextConstants.acceptTermsAndConditionsFirstText,
                      secondText: TextConstants.acceptTermsAndConditionsSecondText,
                      firstTextStyle: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
                      secondTextStyle: AppTextStyles.labelSmall(color: AppColors.primary),
                    ),
                  ),
                ],
              ),

              Obx(
                controller.showAcceptTermsError,
                builder: (BuildContext context, Rx<bool> showAcceptTermsError, _) {
                  return switch (showAcceptTermsError()) {
                    false => const SizedBox(),
                    true => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          TextConstants.youHaveToVerifyAcceptTerms,
                          style: AppTextStyles.bodyMedium(color: AppColors.error),
                        ),
                      ],
                    ),
                  };
                },
              ),

              const SizedBox(height: AppSize.emptySizeHigh),
            ],
          ),
        ),
      );
    }

    Widget buildBottomButton(bool isSmallScreen, bool isTablet) {
      return BottomButtonWidget(
        isSmallScreen: isSmallScreen,
        isTablet: isTablet,
        isLongWidth: true,
        onTap: controller.onContinueUsernamePressed,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          LoginHeaderWidget(isTablet: isTablet),

          Expanded(
            child: SingleChildScrollView(
              child: buildFormContent(isSmallScreen),
            ),
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: AppSize.durationLow),
            child: isKeyboardOpen ? const SizedBox.shrink() : buildBottomButton(isSmallScreen, isTablet),
          ),
        ],
      ),
    );
  }
}
