import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/app_images.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/widgets/custom_back_button.dart';
import 'recharge_screen_args.dart';

const double _opacity = 0.07;
const double _radius = 17.0;
const double _imageSmallScreenSize = 100;

@RoutePage()
class RechargeScreenView extends StatelessWidget {
  const RechargeScreenView({
    super.key,
    required this.args,
  });

  final RechargeScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    Widget infoContainer(String detail, String info, String type) {
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
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(_radius),
                    ),
                    padding: EdgeInsets.all(isSmallScreen ? AppSize.paddingLow : AppSize.paddingNormal),
                    child: Text(
                      detail,
                      style: AppTextStyles.buttonText(
                        fontSize: isSmallScreen ? AppSize.bodyFontSize : AppSize.headlineFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.emptySizeLow),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          info,
                          style: AppTextStyles.labelMedium(fontSize: AppSize.labelFontSize),
                        ),
                        Text(
                          type,
                          style: AppTextStyles.captionText(fontSize: AppSize.smallFontSize),
                        ),
                      ],
                    ),
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
                    TextConstants.reCharge,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelMedium(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: isSmallScreen ? AppSize.emptySizeLow : AppSize.emptySize),

            Center(
              child: AppImages.add_alert(
                height: isSmallScreen ? _imageSmallScreenSize : null,
                width: isSmallScreen ? _imageSmallScreenSize : null,
              ),
            ),
            const SizedBox(height: AppSize.emptySizeLow),
            Text(
              TextConstants.reChargeYourWallet,
              style: AppTextStyles.headlineMedium(),
            ),
            const SizedBox(height: AppSize.emptySizeLow),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.padding),
              child: Text(
                TextConstants.sendChargeAmountToOurBank,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall(color: AppColors.inverseSurface),
              ),
            ),
            const SizedBox(height: AppSize.emptySize),

            infoContainer(
              TextConstants.khanBankAccount,
              TextConstants.khanBankName,
              TextConstants.khanBankDescription,
            ),
            const SizedBox(height: AppSize.emptySizeLow),
            infoContainer(
              args.user?.phone ?? '',
              //TextConstants.transactionAccount,
              TextConstants.transactionDetailTitle,
              TextConstants.transactionDetailDescription,
            ),
          ],
        ),
      ),
    );
  }
}
