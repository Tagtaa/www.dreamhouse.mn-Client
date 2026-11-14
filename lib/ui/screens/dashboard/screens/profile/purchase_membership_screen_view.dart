// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/models/auth/api/subscription/subscription_response_model.dart';
import '../../../../../core/routing/app_navigation.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/buttons/custom_buttons.dart';
import '../../../../components/widgets/custom_back_button.dart';
import 'recharge_screen_args.dart';
import 'widget/purchased_bottom_sheet.dart';

const double _buttonWidth = 150.0;

@RoutePage()
class PurchaseMembershipScreenView extends StatelessWidget {
  const PurchaseMembershipScreenView({
    required this.balance,
    required this.subscriptionModel,
    required this.rechargeScreenArgs,
    super.key,
  });

  final int balance;
  final SubscriptionsResponseModel? subscriptionModel;
  final RechargeScreenArgs rechargeScreenArgs;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    Widget infoContainerBalance(String title, String body) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
            width: AppSize.one,
          ),
          borderRadius: BorderRadius.circular(AppSize.radiusLow),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isSmallScreen ? AppSize.paddingLow : AppSize.paddingNormal, horizontal: AppSize.paddingHighest),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
      );
    }

    Widget infoContainer(BuildContext context, String price, String duration, String subscriptionId) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(AppSize.radius),
                border: Border.all(width: AppSize.one, color: AppColors.onSurface),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppSize.padding, vertical: isSmallScreen ? AppSize.paddingLowest : AppSize.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: '$price₮',
                          style: AppTextStyles.titleMedium(
                            color: AppColors.onSurface,
                            fontSize: AppSize.headlineFontSize,
                          ),
                        ),
                        TextSpan(
                          text: '/$duration',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.inverseSurface,
                            fontSize: AppSize.captionFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppButton.customPrimarySmall(
                    text: TextConstants.purchase,
                    radius: AppSize.radiusHighest,
                    height: AppSize.buttonHeight,
                    width: _buttonWidth,
                    isSmallScreen: isSmallScreen,
                    textStyle: AppTextStyles.captionText(
                      color: AppColors.onPrimary,
                      fontSize: AppSize.labelFontSize,
                    ),
                    onTap: () => showPurchasedBottomSheet(
                      context,
                      duration,
                      price,
                      subscriptionId,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Center(
      child: Scaffold(
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
                    flex: 1,
                    child: CustomBackButton(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      TextConstants.purchaseMembership,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.labelMedium(),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
              infoContainerBalance(balance.toString(), TextConstants.yourBalance),
              SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),

              Center(
                child: AppButton.customPrimarySmall(
                  text: TextConstants.reChargeWallet,
                  backgroundColor: AppColors.secondary,
                  width: AppSize.alertIconSize,
                  radius: AppSize.radiusHighest,
                  isSmallScreen: isSmallScreen,
                  onTap: () => AppNavigation.gotoRechargeRoute(
                    context,
                    args: rechargeScreenArgs,
                  ),
                ),
              ),

              SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLow),

              if (subscriptionModel != null)
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSize.paddingZero),
                    children: subscriptionModel!.subscriptions.map(
                      (SubscriptionModel subscription) {
                        return Column(
                          children: <Widget>[
                            infoContainer(context, subscription.price.toString(), subscription.title, subscription.id),
                            const SizedBox(height: AppSize.emptySizeLow),
                          ],
                        );
                      },
                    ).toList(),

                    //  <Widget>[
                    //   infoContainer(context, '20.000', TextConstants.membershipDurations[0]), // '1 month'
                    //   const SizedBox(height: AppSize.emptySizeLow),

                    //   infoContainer(context, '40.000', TextConstants.membershipDurations[1]), // '2 months'
                    //   const SizedBox(height: AppSize.emptySizeLow),

                    //   infoContainer(context, '55.000', TextConstants.membershipDurations[2]), // '3 months'
                    //   const SizedBox(height: AppSize.emptySizeLow),

                    //   infoContainer(context, '100.000', TextConstants.membershipDurations[3]), // '6 months'
                    //   const SizedBox(height: AppSize.emptySizeLow),

                    //   infoContainer(context, '180.000', TextConstants.membershipDurations[4]), // '1 year'
                    //   const SizedBox(height: AppSize.emptySizeLow),
                    // ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
