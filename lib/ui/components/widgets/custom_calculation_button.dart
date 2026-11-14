// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import '../buttons/custom_buttons.dart';

const double _buttonHeightSize = 66.0;
const double _buttonHeightSmallSize = 44.0;

class CustomCalculationButton extends StatelessWidget {
  const CustomCalculationButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHighest),
        child: AppButton.customPrimarySmall(
          text: TextConstants.calculate,
          height: context.isSmallScreen ? _buttonHeightSmallSize : _buttonHeightSize,
          width: double.infinity,
          onTap: onTap,
        ),
      ),
    );
  }
}
