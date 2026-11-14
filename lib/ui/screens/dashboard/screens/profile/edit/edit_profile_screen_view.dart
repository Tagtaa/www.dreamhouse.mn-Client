import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../../core/utils/validation/form_validation.dart';
import '../../../../../components/buttons/custom_buttons.dart';
import '../../../../../components/buttons/custom_icon_button.dart';
import '../../../../../components/widgets/custom_back_button.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/textfields/search_text_field.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_view.dart';
import 'edit_profile_screen_controller.dart';

const double _sizedBoxSize = 100.0;
const double _sizedBoxSmallScreenSize = 70.0;
const double _sizedBoxSizeLow = 40.0;
const double _sizedBoxSizeSmallScreenLow = 30;
const double _positionSize = 5.0;

@RoutePage()
final class EditProfileScreenView extends BaseScreenView<EditProfileScreenController, DefaultScreenArgs> {
  const EditProfileScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<EditProfileScreenView> createState() => _EditProfileScreenViewState();
}

final class _EditProfileScreenViewState extends BaseScreenViewState<EditProfileScreenView, EditProfileScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, EditProfileScreenController controller) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppSize.paddingNormal),
              child: Column(
                children: <Widget>[
                  SizedBox(height: isSmallScreen ? AppSize.emptySize : AppSize.emptySize),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: CustomBackButton(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          TextConstants.editProfile,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelMedium(),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: AppSize.emptySizeLow),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                              child: switch (controller.user?.user?.profileImage != null && controller.user!.user!.profileImage!.isNotEmpty) {
                                true => CustomImageNetwork(controller.user!.user!.profileImage!),
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
                              onTap: () => controller.onTapImage(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    SearchTextField(
                      controller: controller.usernameController,
                      hintText: TextConstants.usernameFormHintText,
                      isMaterialField: true,
                      suffixIcon: AppIcons.edit_profile,
                      iconColor: AppColors.onSurface,
                      radius: AppSize.radiusLowest,
                      validator: (String? value) => FormValidators.validateUsername(value),
                    ),
                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

                    SearchTextField(
                      controller: controller.emailController,
                      hintText: TextConstants.emailAddress,
                      isMaterialField: true,
                      prefixIcon: AppIcons.email,
                      suffixIcon: AppIcons.edit_profile,
                      iconColor: AppColors.onSurface,
                      isShowSuffixIcon: false,
                      radius: AppSize.radiusLowest,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) => FormValidators.validateEmail(value),
                    ),
                    SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.padding,
                        vertical: isSmallScreen ? AppSize.paddingNormal : AppSize.paddingHigh,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            controller.user?.user?.phone ?? '',
                            style: AppTextStyles.labelMedium(color: const Color.fromRGBO(245, 244, 248, 1), fontWeight: FontWeight.w600),
                          ),
                          AppIcons.calling(),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 100),
                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: AppSize.durationLow),
              child: isKeyboardOpen
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsetsGeometry.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.padding),
                      child: AppButton.customPrimarySmall(
                        text: TextConstants.save,
                        width: double.infinity,
                        isSmallScreen: isSmallScreen,
                        onTap: () async {
                          await controller.onSave();
                          //AppNavigation.popRoute(context);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoContainer(String title, String body) {
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
          padding: const EdgeInsets.all(AppSize.padding),
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
