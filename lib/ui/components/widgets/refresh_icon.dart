import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';

final class RefreshIconView extends StatelessWidget {
  RefreshIconView({super.key, required this.onTap});

  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withOpacity(0.1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.refresh_rounded,
          color: AppColors.primary,
          size: AppSize.iconSizeHigh,
        ),
      ),
    );
  }
}
