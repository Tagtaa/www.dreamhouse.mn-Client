import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_icons.dart';
import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/routing/app_navigation.dart';
import '../../../../core/utils/extensions/size_extensions.dart';
import '../../../components/buttons/custom_buttons.dart';
import '../../../components/widgets/gesture_detector.dart';
import '../../../components/widgets/multi_style_text.dart';
import '../controller/auth_screen_controller.dart';
import '../model/auth_screen_args.dart';

@RoutePage()
class LoginOptionScreenView extends StatefulWidget {
  const LoginOptionScreenView({super.key});

  @override
  State<LoginOptionScreenView> createState() => _LoginOptionScreenViewState();
}

class _LoginOptionScreenViewState extends State<LoginOptionScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;
    final bool isTablet = context.isTablet;
    final double screenHeight = MediaQuery.of(context).size.height;

    const double chatButtonHeight = 80.0;
    final double paddingHeight = (screenHeight * 0.02) * 2;
    final double textHeight = isSmallScreen ? 60.0 : 80.0;
    final double buttonHeight = (isSmallScreen ? 48.0 : 56.0) * 2;
    final double imageGridHeight = screenHeight * 0.3;

    final double usedHeight = chatButtonHeight + paddingHeight + textHeight + buttonHeight + imageGridHeight;
    final double remainingHeight = screenHeight - usedHeight;
    final double spacingUnit = remainingHeight / 3;

    final bool isSquareScreen = context.screenHeight / context.screenWidth < 1.5;

    Widget buildImage(Widget image) {
      return isSquareScreen
          ? SizedBox(
              height: context.screenHeight * 0.25,
              width: context.screenHeight * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.radiusLow),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: image,
                ),
              ),
            )
          : Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.radiusLow),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: image,
                  ),
                ),
              ),
            );
    }

    Widget buildImageGrid() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildImage(AppImages.login_placeholder1()),
              const SizedBox(width: AppSize.emptySizeLowest),
              buildImage(AppImages.login_placeholder2()),
            ],
          ),
          const SizedBox(height: AppSize.emptySizeLow),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              buildImage(AppImages.login_placeholder3()),
              const SizedBox(width: AppSize.emptySizeLowest),
              buildImage(AppImages.login_placeholder4()),
            ],
          ),
        ],
      );
    }

    Widget buildChatButton(bool isSmallScreen) {
      return Container(
        padding: const EdgeInsets.all(AppSize.paddingNormal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Text(
                TextConstants.doYouHaveQuestion,
                style: AppTextStyles.labelSmall(
                  fontSize: isSmallScreen ? AppSize.captionFontSize : AppSize.bodyFontSize,
                  color: AppColors.text,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CustomGestureDetector(
                  onTap: () => AppNavigation.gotoChatbotAnonymousRoute(context),
                  child: AppIcons.chat(size: isSmallScreen ? AppSize.iconSize : AppSize.iconSizeHigh),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSize.padding),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildImageGrid(),

                        SizedBox(
                          height: spacingUnit.clamp(
                            isSmallScreen ? 10.0 : 20.0,
                            isSmallScreen ? 20.0 : 45.0,
                          ),
                        ),
                        Center(
                          child: MultiStyleText(
                            textAlign: TextAlign.center,
                            firstText: TextConstants.readyToExploreFirstText,
                            secondText: TextConstants.readyToExploreSecondText,
                            firstTextStyle: isSmallScreen ? AppTextStyles.headlineMedium(fontSize: AppSize.titleFontSize) : null,
                            secondTextStyle: isSmallScreen ? AppTextStyles.headlineLarge(fontSize: AppSize.headlineFontSize) : null,
                          ),
                        ),

                        SizedBox(height: (spacingUnit * 0.6).clamp(15.0, 30.0)),

                        Center(
                          child: AppButton.primaryLarge(
                            text: TextConstants.login,
                            isLongWidth: !isSmallScreen,
                            isLongHeight: !isSmallScreen,
                            isTablet: isTablet,
                            isSmallScreen: isSmallScreen,
                            onTap: () => AppNavigation.gotoLoginPhoneRoute(context, args: AuthScreenArgs()),
                          ),
                        ),

                        SizedBox(
                          height: (spacingUnit * 0.3).clamp(
                            isSmallScreen ? 10.0 : 20.0,
                            isSmallScreen ? 30.0 : 40.0,
                          ),
                        ),

                        Center(
                          child: AppButton.secondaryLarge(
                            text: TextConstants.signUp,
                            isLongWidth: !isSmallScreen,
                            isLongHeight: !isSmallScreen,
                            isTablet: isTablet,
                            isSmallScreen: isSmallScreen,
                            onTap: () => AppNavigation.gotoLoginPhoneRoute(context, args: AuthScreenArgs(authState: AuthState.signUp)),
                          ),
                        ),

                        SizedBox(height: spacingUnit.clamp(20.0, 60.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Chat button positioned above phone menus
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: buildChatButton(isSmallScreen),
            ),
          ),
        ],
      ),
    );
  }
}
