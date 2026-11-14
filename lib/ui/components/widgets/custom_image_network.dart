import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork(
    this.imagePath, {
    super.key,
    this.boxFit = BoxFit.cover,
  });

  final String imagePath;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      fit: boxFit,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Center(
          child: Container(
            color: AppColors.secondaryBackground,
            child: const Icon(
              Icons.image_not_supported,
              color: AppColors.surface,
              size: AppSize.iconSizeHigh,
            ),
          ),
        );
      },
    );
  }
}
