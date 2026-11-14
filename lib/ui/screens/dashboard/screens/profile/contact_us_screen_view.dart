import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_icons.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/widgets/custom_back_button.dart';

const double _opacity = 0.15;
const double _radius = 17.0;

@RoutePage()
// ignore: must_be_immutable
class ContactUsScreenView extends StatelessWidget {
  const ContactUsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    Widget infoContainer(String info, String type, AppIcons icon) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(_opacity),
                borderRadius: BorderRadius.circular(AppSize.radiusLowest),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSize.padding, vertical: AppSize.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(_radius),
                    ),
                    padding: EdgeInsets.all(isSmallScreen ? AppSize.paddingLow : AppSize.paddingNormal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        icon(),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSize.emptySizeLow),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        info,
                        style: AppTextStyles.labelMedium(fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.headlineFontSize),
                      ),
                      Text(
                        type,
                        style: AppTextStyles.titleLarge(
                          color: AppColors.inverseSurface,
                          fontFamily: fontFamilyRaleway,
                          fontSize: context.isTablet ? AppSize.captionFontSize : AppSize.smallFontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
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
                  flex: 2,
                  child: Text(
                    TextConstants.contactUs,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: AppSize.emptySizeLow),

            infoContainer('+​976 77-800-201', TextConstants.phoneNumber, AppIcons.calling),
            const SizedBox(height: AppSize.emptySizeLow),

            infoContainer('contact@dreamhouse.mn', TextConstants.emailAddress, AppIcons.email),
            const SizedBox(height: AppSize.emptySizeLow),

            infoContainer('DreamHouse', TextConstants.facebook, AppIcons.facebook),
            const SizedBox(height: AppSize.emptySizeLow),
          ],
        ),
      ),
    );
  }
}
