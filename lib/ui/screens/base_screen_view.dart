import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/init/app_locator.dart';
import '../../core/models/rx.dart';
import '../components/widgets/obx.dart';
import 'base_screen_args.dart';
import 'base_screen_controller.dart';

abstract base class BaseScreenView<C extends BaseScreenController<A>, A extends BaseScreenArgs> extends StatefulWidget {
  const BaseScreenView({
    super.key,
    required this.args,
    this.safeArea = const ScaffoldSafeArea(),
  });

  final A args;
  final ScaffoldSafeArea safeArea;
}

abstract base class BaseScreenViewState<T extends BaseScreenView<C, A>, C extends BaseScreenController<A>, A extends BaseScreenArgs> extends State<T> {
  late final C controller;
  final Rx<bool> isControllerReady = Rx<bool>(false);

  @override
  void initState() {
    super.initState();
    controller = ControllerLocator.create<C, A>(hashCode, widget.args);
    WidgetsBinding.instance.addObserver(controller);
    controller.onInitState().then((_) => isControllerReady(set: () => true));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(controller);
    ControllerLocator.dispose<C>(hashCode);
    super.dispose();
  }

  Scaffold builder(BuildContext context, C controller);

  Widget _buildBlurredLoadingIndicator() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: AppSize.filterNumber, sigmaY: AppSize.filterNumber),
      child: Container(
        color: AppColors.barrier,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context(set: () => context);

    final Widget view = Container(
      color: AppColors.background,
      child: SafeArea(
        left: widget.safeArea.left,
        top: widget.safeArea.top,
        right: widget.safeArea.right,
        bottom: widget.safeArea.bottom,
        child: Obx(
          isControllerReady,
          builder: (BuildContext context, Rx<bool> isControllerReady, _) {
            if (isControllerReady()) {
              return builder(context, controller);
            }
            return _buildBlurredLoadingIndicator();
          },
        ),
      ),
    );

    final Widget busyViewIndicator = Obx(
      controller.viewState.isBusy,
      builder: (BuildContext context, Rx<bool> isBusy, _) {
        return switch (isBusy()) {
          true => _buildBlurredLoadingIndicator(),
          false => const SizedBox(),
        };
      },
    );

    return Stack(
      children: <Widget>[
        view,
        busyViewIndicator,
      ],
    );
  }
}

final class ScaffoldSafeArea {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const ScaffoldSafeArea({
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = true,
  });
}
