import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/routing/app_navigation.dart';
import '../../../../components/buttons/custom_buttons.dart';

const double _fontSize = 40.0;
const double _dividerWidth = 60.0;
const double _dividerHeight = 4.0;
const double _radiusSize = 3.0;

class VerificationBottomSheet extends StatefulWidget {
  final String sendToPhoneNumber;
  final VoidCallback? onVerify;
  final String verifyCode;

  /// Runs when "Шалгах" is pressed. Return true to close the sheet and call
  /// [onVerify]; false keeps the sheet open (the caller shows the error).
  /// When null, the button closes the sheet straight away (previous behaviour).
  final Future<bool> Function()? onCheck;

  const VerificationBottomSheet({
    super.key,
    required this.sendToPhoneNumber,
    this.onVerify,
    required this.verifyCode,
    this.onCheck,
  });

  @override
  _VerificationBottomSheetState createState() => _VerificationBottomSheetState();
}

class _VerificationBottomSheetState extends State<VerificationBottomSheet> {
  final TextEditingController _codeController = TextEditingController();
  bool _isChecking = false;

  Future<void> _onCheckPressed() async {
    if (_isChecking) return;

    if (widget.onCheck != null) {
      setState(() => _isChecking = true);
      final bool verified = await widget.onCheck!();
      if (!mounted) return;
      setState(() => _isChecking = false);
      if (!verified) return; // stay on the sheet; caller already showed the error
    }

    widget.onVerify?.call();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _codeController.dispose();
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

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '${TextConstants.sendCodeBelowTo} ',
                      style: AppTextStyles.titleLarge(
                        color: AppColors.onSecondary,
                        fontSize: AppSize.bodyFontSize,
                      ),
                    ),
                    TextSpan(
                      text: widget.sendToPhoneNumber,
                      style: AppTextStyles.titleMedium(
                        color: AppColors.onSecondary,
                        fontSize: AppSize.titleFontSize,
                      ),
                    ),
                    TextSpan(
                      text: ' ${TextConstants.thenClick} ',
                      style: AppTextStyles.titleLarge(
                        color: AppColors.onSecondary,
                        fontSize: AppSize.bodyFontSize,
                      ),
                    ),
                    TextSpan(
                      text: ' ${TextConstants.check}'.toUpperCase(),
                      style: AppTextStyles.titleMedium(
                        color: AppColors.onSecondary,
                        fontSize: AppSize.titleFontSize,
                      ),
                    ),
                    TextSpan(
                      text: '\n${TextConstants.button} ',
                      style: AppTextStyles.titleLarge(
                        color: AppColors.onSecondary,
                        fontSize: AppSize.bodyFontSize,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSize.emptySize),

              Text(
                widget.verifyCode,
                style: AppTextStyles.titleLarge(
                  fontSize: _fontSize,
                  color: AppColors.inverseSurface,
                ),
              ),

              const SizedBox(height: AppSize.emptySize),

              AppButton.primaryLarge(
                text: TextConstants.check,
                isLongWidth: true,
                isEnabled: !_isChecking,
                onTap: _onCheckPressed,
              ),

              const SizedBox(height: AppSize.emptySize),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showVerificationBottomSheet(
  BuildContext? context, {
  required String sendToPhoneNumber,
  required String verifyCode,
  void Function()? onVerify,
  Future<bool> Function()? onCheck,
}) async {
  if (context != null && context.mounted) {
    AppNavigation.popRoute(context);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrier,
      builder: (BuildContext context) {
        return VerificationBottomSheet(
          sendToPhoneNumber: sendToPhoneNumber,
          verifyCode: verifyCode,
          onVerify: onVerify,
          onCheck: onCheck,
        );
      },
    );
  }
}
