import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/utils/extensions/size_extensions.dart';
import 'multi_style_text.dart';

const double _imageSmallScreenSize = 100;
const double _imageSmallScreenSizeHigh = 250;

class EmptySearchingView extends StatelessWidget {
  const EmptySearchingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;

    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(height: isSmallScreen ? AppSize.emptySizeMedium : AppSize.emptySizeLowest),
          AppImages.payment_info_alert(
            height: isSmallScreen ? _imageSmallScreenSize : _imageSmallScreenSizeHigh,
            width: isSmallScreen ? _imageSmallScreenSize : _imageSmallScreenSizeHigh,
          ),
          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySizeLowest),
          MultiStyleText(
            textAlign: TextAlign.center,
            firstText: TextConstants.search,
            secondText: TextConstants.notfound,
            firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
            secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
          ),
          SizedBox(height: isSmallScreen ? AppSize.emptySizeLowest : AppSize.emptySize),
          Text(
            TextConstants.realEstateNotFoundMessage,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall(
              color: AppColors.inverseSurface,
              fontFamily: fontFamilyRaleway,
              fontSize: isSmallScreen ? AppSize.captionFontSize : AppSize.labelFontSize,
            ),
          ),
          //const Spacer(),
        ],
      ),
    );
  }
}
