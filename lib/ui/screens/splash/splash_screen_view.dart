import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../base_screen_args.dart';
import '../base_screen_view.dart';
import 'splash_screen_controller.dart';

const double _logoSize = 125.0;

const double _emptySizeHigh = 30;
const double _emptySizeLow = 15;

@RoutePage()
final class SplashScreenView extends BaseScreenView<SplashScreenController, DefaultScreenArgs> {
  const SplashScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

final class _SplashScreenViewState extends BaseScreenViewState<SplashScreenView, SplashScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, SplashScreenController controller) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          AppImages.splash(
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  AppColors.secondary.withOpacity(0.0),
                  AppColors.secondary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppIcons.logo(size: _logoSize),
                const SizedBox(height: AppSize.emptySizeLowest),
                Text(
                  TextConstants.appName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.displayLarge(),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: _emptySizeHigh,
            child: Text(
              TextConstants.version,
              style: AppTextStyles.labelSmall(
                fontFamily: fontFamilyRaleway,
              ),
            ),
          ),
          Positioned(
            bottom: _emptySizeLow,
            child: Text(
              TextConstants.versionNumber,
              style: AppTextStyles.labelSmall(
                fontFamily: fontFamilyRaleway,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
