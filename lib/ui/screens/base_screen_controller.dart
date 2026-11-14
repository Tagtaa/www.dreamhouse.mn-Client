import 'package:flutter/material.dart';

import '../../core/models/rx.dart';
import '../../core/routing/app_navigation.dart';
import '../../core/services/base_service.dart' as base_service;
import '../../core/utils/app_logger.dart';
import 'base_screen_args.dart';

typedef Service<T> = base_service.Service<T>;

abstract base class BaseScreenController<A extends BaseScreenArgs> with WidgetsBindingObserver {
  final ViewState viewState = ViewState();
  final Rxn<BuildContext> context = Rxn<BuildContext>();

  BaseScreenController(A args);

  @mustCallSuper
  Future<void> onInitState() async {
    AppLogger.debug('$runtimeType.onInitState');
  }

  @mustCallSuper
  void onDispose() {
    AppLogger.debug('$runtimeType.onDispose');
  }

  void pop([void Function()? f]) {
    AppNavigation.popRoute(context()).then((_) => f?.call());
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
}

final class ViewState {
  /// View has been created and appears on the screen.
  /// But it is inaccessible.
  /// There is a progress indicator layer at the top of stack.
  final Rx<bool> _busy = Rx<bool>(false);

  /// View may not have been created yet. A skeleton view appears on the screen.
  final Rx<bool> _loading = Rx<bool>(false);

  Rx<bool> get isBusy => _busy;
  void setBusy(bool status) => _busy(set: () => status);

  Rx<bool> get isLoading => _loading;
  void setLoading(bool status) => _loading(set: () => status);
}
