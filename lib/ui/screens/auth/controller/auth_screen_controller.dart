import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/models/auth/api/forgot_password/forgot_password_response_model.dart';
import '../../../../core/models/auth/api/reset_password/reset_password_response_model.dart';
import '../../../../core/models/auth/api/send_verify/send_verification_code_response_model.dart';
import '../../../../core/models/result.dart';
import '../../../../core/models/rx.dart';
import '../../../../core/routing/app_navigation.dart';
import '../../../../core/services/auth/auth_service.dart';
import '../../../../core/utils/app_functions.dart';
import '../../../components/overlay/alert_notification_overlay.dart';
import '../../base_screen_controller.dart';
import '../login/widget/verification_password_bottom_sheet.dart';
import '../model/auth_screen_args.dart';

enum AuthState {
  login(),
  signUp();

  const AuthState();
}

final class AuthScreenController extends BaseScreenController<AuthScreenArgs> {
  final Service<AuthService> _authService;
  final AuthScreenArgs args;
  final AuthState authState;
  final Rx<bool> showAcceptTermsError = Rx<bool>(false);
  final Rx<bool> isResetPasswordScreen = Rx<bool>(false);

  AuthScreenController(
    this.args,
    this._authService,
  ) : authState = args.authState,
      super(args);

  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;

  final GlobalKey<FormState> formPhoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formPasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formUsernameKey = GlobalKey<FormState>();
  bool acceptTerms = false;

  @override
  Future<void> onInitState() async {
    super.onInitState();

    phoneController = TextEditingController(text: args.phone);
    passwordController = TextEditingController(text: args.password);
    usernameController = TextEditingController();
  }

  Future<void> onContinuePhonePressed() async {
    final bool isValid = formPhoneKey.currentState?.validate() ?? false;

    if (isValid) {
      if (authState == AuthState.signUp) {
        await sendCode();
      } else {
        AppNavigation.gotoLoginPasswordRoute(
          context(),
          args: AuthScreenArgs(
            authState: authState,
            phone: phoneController.text,
          ),
        );
      }
    }
  }

  void onContinuePasswordPressed() {
    final bool isValid = formPasswordKey.currentState?.validate() ?? false;

    if (isValid) {
      if (authState == AuthState.signUp) {
        AppNavigation.gotoLoginUsernameRoute(
          context(),
          args: AuthScreenArgs(
            authState: authState,
            phone: args.phone,
            password: passwordController.text,
          ),
        );
      } else {
        if (isResetPasswordScreen.value) {
          sendResetPassword();
        } else {
          login();
        }
      }
    }
  }

  void onContinueUsernamePressed() {
    final bool isValid = formUsernameKey.currentState?.validate() ?? false;

    if (!acceptTerms) {
      showAcceptTermsError(set: () => true);
    } else if (isValid && acceptTerms) {
      signup();
    }
  }

  void sendResetPassword() async {
    viewState.setBusy(true);

    await _authService().sendResetPassword(phone: args.phone!, password: passwordController.text, code: AppFunctions.resetCode).then(
      (Result<ResetPasswordResponseModel, ApiException> result) {
        result.on(
          success: (_) async {
            await showAlertNotification(
              context(),
              message: TextConstants.resetPasswordSuccessfulText,
              icon: AppImages.success_alert(),
              onDismiss: () => AppNavigation.gotoLoginOptionRoute(context()),
            );
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
            if (e.code == 'OTP_NOT_CONFIRMED') {
              await showVerificationBottomSheet(
                context(),
                sendToPhoneNumber: AppFunctions.sendToNumber,
                verifyCode: AppFunctions.resetCode,
                onVerify: () => isResetPasswordScreen(set: () => true),
              );
            }
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  Future<void> onTapForgotPassword() async {
    viewState.setBusy(true);
    await _authService().sendForgotPasswordCode(phone: phoneController.text).then(
      (Result<ForgotPasswordResponseModel, ApiException> result) {
        result.on(
          success: (ForgotPasswordResponseModel result) async {
            AppFunctions.resetCode = result.data.otpCode;
            AppFunctions.sendToNumber = result.data.sendToNumber;
            await showVerificationBottomSheet(
              context(),
              sendToPhoneNumber: result.data.sendToNumber,
              verifyCode: result.data.otpCode,
              onVerify: () => isResetPasswordScreen(set: () => true),
            );
            passwordController.clear();
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  void login() async {
    viewState.setBusy(true);

    await _authService().login(phone: args.phone!, password: passwordController.text).then(
      (Result<Nothing, ApiException> result) {
        result.on(
          success: (_) {
            AppNavigation.goToDashboardScreen(context());
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  void signup() async {
    viewState.setBusy(true);

    await _authService().signUp(phone: args.phone!, password: args.password!, username: usernameController.text).then(
      (Result<Nothing, ApiException> result) {
        result.on(
          success: (_) {
            AppNavigation.goToDashboardScreen(context());
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
            if (e.code == 'SMS_PARSER_VERIFICATION_REQUIRED') {
              await showVerificationBottomSheet(
                context(),
                sendToPhoneNumber: AppFunctions.sendToNumber,
                verifyCode: AppFunctions.otpCode,
                onVerify: () {
                  AppNavigation.gotoLoginPasswordRoute(
                    context(),
                    args: AuthScreenArgs(
                      authState: AuthState.signUp,
                      phone: AppFunctions.phoneNumber,
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
    viewState.setBusy(false);
  }

  Future<void> sendCode() async {
    viewState.setBusy(true);
    await _authService()
        .sendCode(
          phone: phoneController.text,
        )
        .then(
          (Result<SendVerificationCodeResponseModel, ApiException> result) {
            result.on(
              success: (SendVerificationCodeResponseModel result) async {
                AppFunctions.otpCode = result.data.otpCode;
                AppFunctions.sendToNumber = result.data.sendToNumber;
                AppFunctions.phoneNumber = result.data.phone;
                await showVerificationBottomSheet(
                  context(),
                  sendToPhoneNumber: result.data.sendToNumber,
                  verifyCode: result.data.otpCode,
                  onVerify: () {
                    //login();
                    AppNavigation.gotoLoginPasswordRoute(
                      context(),
                      args: AuthScreenArgs(
                        authState: AuthState.signUp,
                        phone: result.data.phone,
                      ),
                    );
                  },
                );
              },
              failure: (ApiException e) async {
                await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
              },
            );
          },
        );
    viewState.setBusy(false);
  }

  void resetFormData() {
    phoneController.clear();
    passwordController.clear();
    usernameController.clear();
    acceptTerms = false;
  }

  @override
  void onDispose() {
    phoneController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onDispose();
  }
}
