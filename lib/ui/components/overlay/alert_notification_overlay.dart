import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/routing/app_navigation.dart';

const int _durationAlert = 5000;

class NotificationOverlay extends StatefulWidget {
  final String message;
  final String? title;
  final String? primaryButtonText;
  final Widget icon;
  final VoidCallback? onDismiss;
  final VoidCallback? onButtonPressed;
  final bool isAutoDismiss;

  const NotificationOverlay({
    super.key,
    required this.message,
    this.title,
    this.primaryButtonText,
    required this.icon,
    this.onDismiss,
    this.onButtonPressed,
    this.isAutoDismiss = true,
  });

  @override
  _NotificationOverlayState createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppSize.durationHigh),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );

    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward();

    if (widget.isAutoDismiss) {
      Future<void>.delayed(const Duration(milliseconds: _durationAlert), () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss?.call();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: AppSize.filterNumber, sigmaY: AppSize.filterNumber),
            child: Container(
              color: AppColors.barrier,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: widget.icon,
                          ),

                          if (widget.title != null)
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Text(
                                (widget.title ?? '').toUpperCase(),
                                style: AppTextStyles.labelSmall(),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          const SizedBox(height: AppSize.emptySize),

                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Text(
                              widget.title != null ? widget.message : widget.message.toUpperCase(),
                              style: AppTextStyles.labelSmall(),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: AppSize.emptySize),

                          if (widget.onButtonPressed != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    _dismiss();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    TextConstants.cancel,
                                    style: AppTextStyles.buttonText(),
                                  ),
                                ),
                                const SizedBox(width: AppSize.paddingLow),

                                ElevatedButton(
                                  onPressed: () {
                                    widget.onButtonPressed?.call();
                                    _dismiss();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.buttonText,
                                    backgroundColor: AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    widget.primaryButtonText ?? TextConstants.ok,
                                    style: AppTextStyles.buttonText(),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),

                  if (widget.isAutoDismiss)
                    GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showAlertNotification(
  BuildContext? context, {
  String? message,
  String? title,
  String? primaryButtonText,
  Widget? icon,
  void Function()? onDismiss,
  void Function()? onButtonPressed,
  bool isCallPop = false,
  bool isAutoDismiss = true,
}) async {
  if (context != null && context.mounted) {
    if (isCallPop) {
      AppNavigation.popRoute(context);
    }
    await showDialog(
      context: context,
      barrierDismissible: isAutoDismiss,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (BuildContext context) {
        return NotificationOverlay(
          icon: icon ?? AppImages.success_alert(),
          message: message ?? TextConstants.successNotificationMessage,
          title: title,
          primaryButtonText: primaryButtonText,
          onDismiss: onButtonPressed != null
              ? null
              : () {
                  AppNavigation.popRoute(context);
                  onDismiss?.call();
                },
          onButtonPressed: onButtonPressed == null
              ? null
              : () {
                  onButtonPressed();
                  AppNavigation.popRoute(context);
                  onDismiss?.call();
                },
          isAutoDismiss: isAutoDismiss,
        );
      },
    );
  }
}

Future<void> showIdeaAlertNotification(
  BuildContext? context, {
  String? message,
  String? title,
  String? primaryButtonText,
  Widget? icon,
  void Function()? onDismiss,
  void Function()? onButtonPressed,
  bool isCallPop = false,
  bool isAutoDismiss = true,
}) async {
  if (context != null && context.mounted) {
    if (isCallPop) {
      AppNavigation.popRoute(context);
    }
    await showDialog(
      context: context,
      barrierDismissible: isAutoDismiss,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (BuildContext context) {
        return NotificationOverlay(
          icon: icon ?? AppImages.success_alert(),
          message: message ?? TextConstants.successNotificationMessage,
          title: title,
          primaryButtonText: primaryButtonText,
          onDismiss: () {
            AppNavigation.popRoute(context);
            onDismiss?.call();
          },
          onButtonPressed: onButtonPressed == null
              ? null
              : () {
                  onButtonPressed();
                  AppNavigation.popRoute(context);
                  onDismiss?.call();
                },
          isAutoDismiss: isAutoDismiss,
        );
      },
    );
  }
}
