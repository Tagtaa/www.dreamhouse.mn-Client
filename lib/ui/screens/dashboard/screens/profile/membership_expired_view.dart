import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/app_images.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/routing/app_navigation.dart';
import '../../../../components/buttons/custom_buttons.dart';
import '../../../../components/buttons/custom_icon_button.dart';
import '../../../../components/widgets/custom_back_button.dart';
import 'profile_screen_args.dart';

const double _width = 160.0;
const double _height = 50.0;

@RoutePage()
class MembershipExpiredView extends StatelessWidget {
  const MembershipExpiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: AppSize.emptySizeHigh),
            const Row(
              children: <Widget>[
                Expanded(
                  child: CustomBackButton(),
                ),
              ],
            ),
            AppImages.payment_info_alert(),

            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: AppSize.paddingHighest),
              child: Text(TextConstants.yourMembershipHasExpired, textAlign: TextAlign.center, style: AppTextStyles.headlineMedium()),
            ),

            const SizedBox(height: AppSize.emptySizeLow),
            Text(
              TextConstants.youCanAllFunctionsAfterPurchased,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
            ),

            const SizedBox(height: AppSize.emptySize),

            infoContainer(context, TextConstants.constructionMaterialCostCalculation),
            const SizedBox(height: AppSize.emptySizeLow),

            infoContainer(context, TextConstants.readProfessionalArticlesAndIdeas),
            const SizedBox(height: AppSize.emptySizeLow),

            infoContainer(context, TextConstants.learnMaterialDetailsForSelection),
            const SizedBox(height: AppSize.emptySizeLow),

            AppButton.customPrimarySmall(
              text: TextConstants.purchase,
              radius: AppSize.radiusHighest,
              height: _height,
              width: _width,
              textStyle: AppTextStyles.captionText(
                color: AppColors.onPrimary,
                fontSize: AppSize.labelFontSize,
              ),
              onTap: () => AppNavigation.gotoProfileRoute(context, args: const ProfileScreenArgs(isMembershipExpired: true)),
              // showPurchasedBottomSheet(
              //   context,
              //   '1 month',
              //   '20000',
              // ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget infoContainer(BuildContext context, String detail) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.radius),
              border: Border.all(width: AppSize.one, color: AppColors.borderColor),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSize.padding, vertical: AppSize.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomIconButton(icon: AppIcons.icon_pin()),
                const SizedBox(width: AppSize.emptySizeLow),
                Expanded(
                  child: Text(
                    detail,
                    style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
