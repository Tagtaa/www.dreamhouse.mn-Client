import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import '../buttons/custom_icon_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onBack});

  final void Function()? onBack;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    return Align(
      alignment: Alignment.centerLeft,
      child: CustomIconButton(
        icon: AppIcons.back(size: AppSize.iconSizeLowest),
        size: isSmallScreen ? AppSize.iconSizeNormal : AppSize.iconButtonSize,
        onTap: () {
          if (onBack != null) {
            onBack?.call();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
