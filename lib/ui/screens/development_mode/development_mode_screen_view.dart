import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../components/buttons/custom_buttons.dart';
import '../../components/widgets/custom_back_button.dart';
import '../../components/widgets/ellipse.dart';
import '../../components/widgets/multi_style_text.dart';

@RoutePage()
class DevelopmentModeScreenView extends StatelessWidget {
  const DevelopmentModeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const EllipseView(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.paddingNormal,
              ),
              child: Column(
                children: [
                  const CustomBackButton(),

                  const Spacer(),

                  AppImages.warning_alert(
                    color: AppColors.inversePrimary,
                  ),

                  const SizedBox(height: AppSize.emptySizeHigh),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.paddingHighest,
                    ),
                    child: Column(
                      children: [
                        const MultiStyleText(
                          firstText: TextConstants.maintenanceModeFirstText,
                          secondText: TextConstants.maintenanceModeSecondText,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSize.emptySizeMedium),
                        Text(
                          TextConstants.maintenanceDescriptionText,
                          style: AppTextStyles.labelSmall(
                            color: AppColors.inverseSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSize.emptySizeMedium),

                  AppButton.customPrimarySmall(
                    text: TextConstants.maintenanceBackButtonText,
                    backgroundColor: AppColors.onPrimary,
                    textStyle: AppTextStyles.buttonText(
                      color: AppColors.onSecondary,
                    ),
                    onTap: () => Navigator.of(context).maybePop(),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
