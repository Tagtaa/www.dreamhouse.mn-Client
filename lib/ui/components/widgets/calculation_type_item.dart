import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import 'custom_image_network.dart';

class CalculationTypeItem extends StatelessWidget {
  const CalculationTypeItem({
    super.key,
    required this.image,
    required this.title,
    required this.type,
  });

  final String? image;
  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dh(AppSize.itemHeight),

      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radius),
            child: switch (image != null) {
              true => CustomImageNetwork(image!),
              false => const Placeholder(),
            },
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.radius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppSize.gradientColors,
                stops: AppSize.gradientColorStops,
              ),
            ),
          ),

          Positioned(
            bottom: AppSize.paddingHigh,
            left: AppSize.paddingLow,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                type,
                style: AppTextStyles.buttonText(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: AppSize.padding,
            left: AppSize.paddingLow,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: AppTextStyles.buttonText(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSize.labelFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
