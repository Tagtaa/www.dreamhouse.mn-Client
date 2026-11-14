// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/init/app_locator.dart';
import '../../../../../../core/models/calculation/calculation_type_response_model.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../../components/widgets/custom_image_network.dart';
import '../../../../../components/widgets/gesture_detector.dart';
import '../../profile/profile_screen_args.dart';

const double _imageRadius = 15.0;

class EstimationTypeScreenView extends StatelessWidget {
  const EstimationTypeScreenView({
    super.key,
    required this.calculationType,
    required this.route,
  });

  final CalculationType calculationType;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
        if (calculationType.isPremium && !ServiceLocator.get<AuthService>().isMember) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                TextConstants.premiumMembersOnly,
                style: AppTextStyles.buttonText(),
              ),
              duration: const Duration(milliseconds: AppSize.animationDurationNormal),
              backgroundColor: AppColors.secondary,
            ),
          );
          AppNavigation.gotoProfileRoute(context, args: const ProfileScreenArgs(isMembershipExpired: true));

          //AppNavigation.gotoMemberShipExpiredRoute(context);
        } else {
          AppNavigation.gotoEstimationRoute(context, route: route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingLow),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_imageRadius),
                      child: switch (calculationType.imageUrl != null) {
                        true => CustomImageNetwork(calculationType.imageUrl!),
                        false => const Placeholder(),
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.emptySizeLowest),
                  Text(
                    calculationType.nameMn,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.titleMedium(
                      color: AppColors.onSurface,
                      fontSize: context.isTablet ? AppSize.bodyFontSize : AppSize.labelFontSize,
                    ),
                  ),
                  const SizedBox(height: AppSize.emptySizeLowest),
                ],
              ),

              if (calculationType.isPremium)
                Positioned(
                  right: AppSize.paddingLow,
                  top: AppSize.paddingLow,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.customButton,
                      borderRadius: BorderRadius.circular(AppSize.radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        TextConstants.members,
                        style: AppTextStyles.bodyMedium(
                          fontFamily: fontFamilyRaleway,
                          color: AppColors.buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
