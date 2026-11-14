import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/init/app_locator.dart';
import '../../../../../../core/models/auth/api/subscription/purchase_membership_response_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../components/buttons/custom_buttons.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';

const double _dividerWidth = 60.0;
const double _dividerHeight = 4.0;
const double _radiusSize = 3.0;

class PurchasedBottomSheet extends StatefulWidget {
  final String price;
  final String duration;
  final VoidCallback? onVerify;

  const PurchasedBottomSheet({
    super.key,
    required this.price,
    required this.duration,
    this.onVerify,
  });

  @override
  _PurchasedBottomSheetState createState() => _PurchasedBottomSheetState();
}

class _PurchasedBottomSheetState extends State<PurchasedBottomSheet> {
  String verificationCode = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: AppSize.filterNumber, sigmaY: AppSize.filterNumber),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSize.radiusHigh),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingNormal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: _dividerWidth,
                height: _dividerHeight,
                decoration: BoxDecoration(
                  color: AppColors.inverseSurface,
                  borderRadius: BorderRadius.circular(_radiusSize),
                ),
              ),

              const SizedBox(height: AppSize.emptySize),

              AppImages.success_alert(),

              Padding(
                padding: const EdgeInsets.all(AppSize.padding),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: TextConstants.areYouSurePurchase,
                        style: AppTextStyles.headlineMedium(),
                      ),
                      TextSpan(
                        text: ' ${widget.duration} ',
                        style: AppTextStyles.headlineMedium(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: TextConstants.memberWith,
                        style: AppTextStyles.headlineMedium(),
                      ),
                      TextSpan(
                        text: ' ${widget.price} ',
                        style: AppTextStyles.headlineMedium(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' ?',
                        style: AppTextStyles.headlineMedium(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSize.emptySize),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: AppButton.customPrimarySmall(
                      backgroundColor: AppColors.secondaryBackground,
                      textStyle: AppTextStyles.buttonText(color: AppColors.onSurface),
                      text: TextConstants.cancel,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: AppSize.emptySizeLowest),

                  Expanded(
                    child: AppButton.customPrimarySmall(
                      text: TextConstants.yes,
                      onTap: () {
                        widget.onVerify?.call();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSize.emptySize),
            ],
          ),
        ),
      ),
    );
  }
}

void showPurchasedBottomSheet(BuildContext context, String price, String duration, String subscriptionId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.barrier,
    builder: (BuildContext context) {
      return PurchasedBottomSheet(
        price: price,
        duration: duration,
        onVerify: () async {
          await ServiceLocator.get<AuthService>()
              .postMembership(subscriptionId)
              .then(
                (Result<PurchaseMemberShipResponseModel, ApiException> result) => result.on(
                  success: (PurchaseMemberShipResponseModel response) {
                    if (!context.mounted) {
                      return;
                    }

                    if (response.success == true) {
                      Navigator.pop(context);
                      AppNavigation.goToSplashScreen(context);
                    }
                  },
                  failure: (ApiException e) async {
                    await showAlertNotification(context, message: e.message, icon: AppImages.warning_alert());
                  },
                ),
              );
        },
      );
    },
  );
}
