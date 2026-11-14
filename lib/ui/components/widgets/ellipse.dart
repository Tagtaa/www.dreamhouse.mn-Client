import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

const double _backgroundEllipseLeft = -110;
const double _backgroundEllipseTop = -115;
const double _backgroundEllipseWidth = 362;
const double _backgroundEllipseHeight = 356;

class EllipseView extends StatelessWidget {
  const EllipseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _backgroundEllipseLeft,
      top: _backgroundEllipseTop,
      child: Container(
        width: _backgroundEllipseWidth,
        height: _backgroundEllipseHeight,
        decoration: const BoxDecoration(
          color: AppColors.circle,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
