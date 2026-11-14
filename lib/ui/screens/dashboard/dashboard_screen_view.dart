import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../core/routing/app_navigation.dart';
import '../base_screen_args.dart';
import '../base_screen_view.dart';
import 'dashboard_screen_controller.dart';
import 'screens/profile/profile_screen_args.dart';

const double _circleSize = 6.0;
const double _elevation = 8.0;

@RoutePage()
final class DashboardScreenView extends BaseScreenView<DashboardScreenController, DefaultScreenArgs> {
  const DashboardScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  }) : super(
         safeArea: const ScaffoldSafeArea(bottom: false),
       );

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

final class _DashboardScreenViewState extends BaseScreenViewState<DashboardScreenView, DashboardScreenController, DefaultScreenArgs> {
  @override
  Scaffold builder(BuildContext context, DashboardScreenController controller) {
    if (controller.pages.isEmpty) {
      return const Scaffold();
    }

    return Scaffold(
      body: AutoTabsScaffold(
        animationDuration: Duration.zero,
        routes: controller.pages.map((DashboardPageItem pageItem) => pageItem.page).toList(),
        bottomNavigationBuilder: (BuildContext context, TabsRouter tabsRouter) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: (int index) {
              if (index == 3) {
                AppNavigation.gotoProfileRoute(context, args: const ProfileScreenArgs());
                return;
              }

              if (tabsRouter.activeIndex == index) {
                tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
            items: <BottomNavigationBarItem>[
              ...List<BottomNavigationBarItem>.generate(
                controller.pages.length,
                (int index) => BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: AppSize.durationNormal),
                        transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                        child: tabsRouter.activeIndex == index ? controller.pages[index].filledIcon : controller.pages[index].outlineIcon,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: AppSize.durationNormal),
                        margin: const EdgeInsets.only(top: AppSize.paddingLowest),
                        width: tabsRouter.activeIndex == index ? _circleSize : 0,
                        height: tabsRouter.activeIndex == index ? _circleSize : 0,
                        decoration: BoxDecoration(
                          color: tabsRouter.activeIndex == index ? AppColors.customButton : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    controller.profileOutlineIcon,
                    const SizedBox(
                      height: AppSize.paddingLowest + _circleSize,
                    ),
                  ],
                ),
                label: '',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.background,
            elevation: _elevation,
          );
        },
      ),
    );
  }
}
