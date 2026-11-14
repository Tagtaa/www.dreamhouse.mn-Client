import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/utils/extensions/size_extensions.dart';
import '../../../../core/utils/validation/form_validation.dart';
import '../../../components/widgets/multi_style_text.dart';
import '../../../components/widgets/textfields/custom_text_field.dart';
import '../../base_screen_view.dart';
import '../model/auth_screen_args.dart';
import '../controller/auth_screen_controller.dart';
import 'widget/bottom_button.dart';
import 'widget/login_header.dart';
import 'widget/number_pad.dart';

@RoutePage()
final class LoginPhoneNumberScreenView extends BaseScreenView<AuthScreenController, AuthScreenArgs> {
  const LoginPhoneNumberScreenView({super.key, required super.args})
    : super(
        safeArea: const ScaffoldSafeArea(bottom: true),
      );

  @override
  State<LoginPhoneNumberScreenView> createState() => _LoginPhoneNumberScreenViewState();
}

final class _LoginPhoneNumberScreenViewState extends BaseScreenViewState<LoginPhoneNumberScreenView, AuthScreenController, AuthScreenArgs> {
  @override
  Scaffold builder(BuildContext context, AuthScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isTablet = context.isTablet;

    Widget buildFormContent(bool isSmallScreen) {
      return Form(
        key: controller.formPhoneKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: switch (isSmallScreen) {
                true => const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal, vertical: AppSize.paddingLow),
                false => const EdgeInsets.all(AppSize.paddingNormal),
              },
              child: MultiStyleText(
                firstText: TextConstants.loginPhoneTitleFirst,
                secondText: TextConstants.loginPhoneTitleSecond,
                firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
              ),
            ),

            const SizedBox(height: AppSize.emptySizeLowest),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: Text(
                TextConstants.loginPhoneDescription,
                style: AppTextStyles.labelSmall(color: AppColors.surface),
              ),
            ),

            SizedBox(height: isSmallScreen ? AppSize.emptySizeLow : AppSize.emptySize),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: PhoneTextField(
                key: const ValueKey<String>('phone_field'),
                controller: controller.phoneController,
                hintText: TextConstants.loginPhoneHint,
                validator: FormValidators.validatePhoneNumber,
              ),
            ),

            SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

            Expanded(
              child: CustomNumberPad(
                controller: controller.phoneController,
                maxNumberLength: AppSize.phoneNumberMaxLimit,
              ),
            ),

            SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeHigh),
          ],
        ),
      );
    }

    Widget buildBottomButton(bool isSmallScreen, bool isTablet) {
      return BottomButtonWidget(
        isSmallScreen: isSmallScreen,
        isLongWidth: true,
        isTablet: isTablet,
        onTap: controller.onContinuePhonePressed,
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

          buildBottomButton(isSmallScreen, isTablet),
        ],
      ),
    );
  }
}
