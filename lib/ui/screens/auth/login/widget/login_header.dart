import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_images.dart';
import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/widgets/custom_back_button.dart';

class LoginHeaderWidget extends StatelessWidget {
  final bool isTablet;

  const LoginHeaderWidget({
    super.key,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * (isTablet ? 0.2 : 0.15),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            top: AppSize.zero,
            left: AppSize.zero,
            right: AppSize.zero,
            child: AppImages.undraw_city_life_gnpr(
              fit: BoxFit.fill,
              height: context.screenHeight * (isTablet ? 0.2 : 0.15),
            ),
          ),
          const Positioned(
            top: AppSize.emptySizeMedium,
            left: AppSize.emptySizeLow,
            child: CustomBackButton(),
          ),
        ],
      ),
    );
  }
}
