import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';

import '../../../ui/components/overlay/alert_notification_overlay.dart';
import '../../configs/constants/app_images.dart';
import '../../configs/constants/text_constants.dart';
import '../../routing/app_navigation.dart';
import '../base_service.dart';

const int _kAskPermissionMaxCount = 2;

final class PermissionService extends BaseService<PermissionService> {
  final List<_CustomPermission> _permissions = <_CustomPermission>[
    //_CustomPermission(Permission.locationWhenInUse),
    //_CustomPermission(Permission.camera),
    _CustomPermission(Permission.photos),
    //_CustomPermission(Permission.notification),
    if (Platform.isAndroid) _CustomPermission(Permission.ignoreBatteryOptimizations),
  ];
  final Completer<void> _permissionsCompleter = Completer<void>();
  bool _isCheckingInProgress = false;

  @override
  Future<PermissionService> init() async {
    super.init();
    await _checkAndRequest();
    await _permissionsCompleter.future;
    return this;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkAndRequest();
    }
  }

  Future<void> _checkAndRequest() async {
    if (_isCheckingInProgress) {
      return;
    }
    _isCheckingInProgress = true;

    for (final _CustomPermission p in _permissions) {
      p.askCount = 0;
    }

    final Map<Permission, PermissionStatus> statuses = await _getPermissionStatuses((Permission val) async => await val.status);

    if (_isAllGranted(statuses)) {
      _setPermissionsGranted();
    } else if (_isAnyDenied(statuses)) {
      await showAlertNotification(
        AppNavigation.rootNavigatorKey.currentContext,
        title: TextConstants.dialogPermissionRequestTitle,
        message: TextConstants.dialogPermissionRequestMessage,
        icon: AppImages.warning_alert(),
        isAutoDismiss: false,
        onButtonPressed: () {},
      );
      // await DialogUtils.showPermissionRequestDialog(null);
      await _request();
    } else {
      await _handleFailure();
    }

    _isCheckingInProgress = false;
  }

  Future<void> _request() async {
    final Map<Permission, PermissionStatus> statuses = await _getPermissionStatuses((Permission val) async => await val.request());

    if (_isAllGranted(statuses)) {
      _setPermissionsGranted();
    } else if (_isAnyDenied(statuses) && _permissions.any((_CustomPermission val) => val.askCount >= _kAskPermissionMaxCount)) {
      await _request();
    } else {
      await _handleFailure();
    }
  }

  Future<Map<Permission, PermissionStatus>> _getPermissionStatuses(
    Future<PermissionStatus> Function(Permission permission) fn,
  ) async {
    final Map<Permission, PermissionStatus> statuses = <Permission, PermissionStatus>{};
    for (final _CustomPermission customPermission in _permissions) {
      final Permission permission = customPermission.permission;
      if (permission is PermissionWithService) {
        final ServiceStatus serviceStatus = await permission.serviceStatus;
        if (serviceStatus.isDisabled) {
          continue;
        }
      }
      final PermissionStatus status = await fn(permission);

      customPermission.askCount++;
      statuses[permission] = status;
    }
    return statuses;
  }

  void _setPermissionsGranted() {
    if (!_permissionsCompleter.isCompleted) {
      _permissionsCompleter.complete();
    }
  }

  Future<void> _handleFailure() async {
    await showAlertNotification(
      AppNavigation.rootNavigatorKey.currentContext,
      title: TextConstants.dialogPermissionFailTitle,
      message: TextConstants.dialogPermissionFailMessage,
      primaryButtonText: TextConstants.dialogPermissionFailPrimaryButton,
      icon: AppImages.warning_alert(),
      isAutoDismiss: false,
      onButtonPressed: () {},
    );
    //  await DialogUtils.showPermissionFailDialog(null);
    openAppSettings();
  }

  bool _isAllGranted(Map<Permission, PermissionStatus> statuses) => statuses.values.every((PermissionStatus val) => val.isGranted);
  bool _isAnyDenied(Map<Permission, PermissionStatus> statuses) => statuses.values.any((PermissionStatus val) => val.isDenied);
}

final class _CustomPermission {
  final Permission permission;
  int askCount = 0;

  _CustomPermission(this.permission);
}
