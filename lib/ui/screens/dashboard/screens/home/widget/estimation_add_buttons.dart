// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_size.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../components/buttons/custom_buttons.dart';

const double _buttonHeight = 35.0;

class EstimationAddButtons extends StatelessWidget {
  const EstimationAddButtons({
    super.key,
    required this.text,
    this.width = 158.5,
    required this.onTap,
  });

  final String text;
  final double width;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AppButton.customPrimarySmall(
          text: text,
          radius: AppSize.radius,
          height: _buttonHeight,
          width: width,
          icon: Icons.add,
          backgroundColor: AppColors.customButton,
          onTap: onTap,
        ),
      ],
    );
  }
}
