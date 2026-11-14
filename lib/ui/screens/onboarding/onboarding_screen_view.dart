import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/routing/app_navigation.dart';
import '../../../core/services/local_storage/local_storage_service.dart';
import '../../components/buttons/custom_buttons.dart';
import '../../components/buttons/custom_icon_button.dart';
import '../../components/widgets/multi_style_text.dart';
import 'onboarding_data_model.dart';

const double _skipButtonWidth = 86.0;
const double _skipButtonHeight = 38.0;

const double _emptySize = 60.0;
const double _dividerWidth = 70.0;
const double _dividerHeight = 4.0;

const double _dividerRadius = 4.0;
const double _positionBottomSize = 120.0;

const double _paddingDivider = 50.0;
const double _paddingHorizontal = 40.0;

@RoutePage()
class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  int currentIndex = 0;

  final List<OnboardingData> onboardingPages = <OnboardingData>[
    OnboardingData(
      image: AppImages.onboarding1,
      firstText: TextConstants.onboarding1FirstText,
      secondText: TextConstants.onboarding1SecondText,
      description: TextConstants.onboarding1Description,
    ),
    OnboardingData(
      image: AppImages.onboarding2,
      firstText: TextConstants.onboarding2FirstText,
      secondText: TextConstants.onboarding2SecondText,
      description: TextConstants.onboarding2Description,
    ),
    OnboardingData(
      image: AppImages.onboarding3,
      firstText: TextConstants.onboarding3FirstText,
      secondText: TextConstants.onboarding3SecondText,
      description: TextConstants.onboarding3Description,
    ),
  ];

  Future<void> nextPage() async {
    if (currentIndex < onboardingPages.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      await skip();
    }
  }

  Future<void> skip() async {
    final LocalStorageService storageService = ServiceLocator.get<LocalStorageService>();
    await storageService.write(Keys.hasSeenOnboarding, 'true');

    AppNavigation.goToDashboardScreen(context);
  }

  void previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingLow,
          top: _paddingDivider,
          right: AppSize.paddingLow,
          bottom: AppSize.paddingLow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppIcons.logo(
                    size: AppSize.logoSize,
                  ),
                  AppButton.customPrimarySmall(
                    width: _skipButtonWidth,
                    height: _skipButtonHeight,
                    backgroundColor: AppColors.inversePrimary,
                    textStyle: AppTextStyles.labelSmall(color: AppColors.inverseSecondary),
                    text: TextConstants.skip,
                    onTap: skip,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.emptySizeHigh),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: SizedBox(
                height: _emptySize,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: AppSize.durationLow),
                  child: MultiStyleText(
                    key: ValueKey<int>(currentIndex),
                    firstText: onboardingPages[currentIndex].firstText,
                    secondText: onboardingPages[currentIndex].secondText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.emptySize),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingNormal),
              child: SizedBox(
                height: _emptySize,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: AppSize.durationLow),
                  child: Text(
                    key: ValueKey<String>('desc_$currentIndex'),
                    onboardingPages[currentIndex].description,
                    style: AppTextStyles.labelSmall(color: AppColors.surface),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.emptySize),

            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.radiusMedium),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: AppSize.durationLow),
                        child: onboardingPages[currentIndex].image.call(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: _positionBottomSize,
                    child: Container(
                      width: _dividerWidth,
                      height: _dividerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_dividerRadius),
                        color: Colors.grey.withOpacity(AppSize.opacityHighest),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (currentIndex + 1) / 3,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: AppSize.durationLow),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_dividerRadius),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: _paddingDivider,
                    left: _paddingHorizontal,
                    right: _paddingHorizontal,
                    child: Row(
                      mainAxisAlignment: currentIndex == 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: <Widget>[
                        if (currentIndex > 0) ...<Widget>[
                          CustomIconButton(
                            size: AppSize.logoSize,
                            icon: AppIcons.arrow_left(size: AppSize.iconSizeLow),
                            onTap: previousPage,
                          ),
                          const SizedBox(width: AppSize.emptySizeLow),
                        ],

                        AppButton.primaryLarge(
                          text: currentIndex == onboardingPages.length - 1 ? TextConstants.getStarted : TextConstants.next,
                          onTap: nextPage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
