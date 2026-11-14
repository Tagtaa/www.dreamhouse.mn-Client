import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_product_constants.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/services/auth/auth_service.dart';
import '../base_screen_args.dart';
import '../base_screen_controller.dart';

final class DashboardScreenController extends BaseScreenController<DefaultScreenArgs> {
  DashboardScreenController(
    super.args,
  );

  @override
  Future<void> onInitState() async {
    super.onInitState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    await Future.wait<void>(
      <Future<void>>[
        ServiceLocator.get<AuthService>().getCurrentUser(),
      ],
    );
  }

  List<DashboardPageItem> get pages => <DashboardPageItem>[
    DashboardPageItem(
      page: HomeScreenWrapperRoute(),
      filledIcon: AppProductConstants.menuIconLists[0]['filled'](key: 'filled'),
      outlineIcon: AppProductConstants.menuIconLists[0]['outline'](key: 'outline'),
    ),
    DashboardPageItem(
      page: IdeaScreenWrapperRoute(),
      filledIcon: AppProductConstants.menuIconLists[1]['filled'](key: 'filled'),
      outlineIcon: AppProductConstants.menuIconLists[1]['outline'](key: 'outline'),
    ),
    DashboardPageItem(
      page: MaterialScreenWrapperRoute(),
      filledIcon: AppProductConstants.menuIconLists[2]['filled'](key: 'filled'),
      outlineIcon: AppProductConstants.menuIconLists[2]['outline'](key: 'outline'),
    ),
  ];

  Widget get profileFilledIcon => AppProductConstants.menuIconLists[3]['filled'](key: 'filled');
  Widget get profileOutlineIcon => AppProductConstants.menuIconLists[3]['outline'](key: 'outline');
}

class DashboardPageItem {
  final PageRouteInfo page;
  final Widget filledIcon;
  final Widget outlineIcon;

  const DashboardPageItem({
    required this.page,
    required this.filledIcon,
    required this.outlineIcon,
  });
}
