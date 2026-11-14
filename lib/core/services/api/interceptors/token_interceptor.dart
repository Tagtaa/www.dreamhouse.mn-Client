import 'dart:io';

import 'package:dio/dio.dart';

import '../../auth/auth_service.dart';
import '../../base_service.dart';
import '../constants/api_paths.dart';

final class TokenInterceptor extends Interceptor {
  final Service<AuthService> _authService;

  TokenInterceptor(this._authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (<String>[
      ApiPaths.login,
      ApiPaths.sendVerificationCode,
      ApiPaths.signup,
      ApiPaths.refreshToken,
      ApiPaths.forgotPassword,
      ApiPaths.resetPassword,
      ApiPaths.anonymousMessagesSend,
      ApiPaths.anonymousMessagesSendImage,
      ApiPaths.anonymousMessagesUserMessages,
    ].contains(options.path)) {
      return handler.next(options);
    }

    final String? token = await switch (options.path) {
      == ApiPaths.refreshToken => _authService().getRefreshToken(),
      _ => _authService().getAccessToken(),
    };

    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      handler.next(options);
    } else {
      await _handleLogout();
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized && err.requestOptions.path != ApiPaths.login) {
      await _handleLogout();
    } else {
      handler.next(err);
    }
  }

  Future<void> _handleLogout() async {
    await _authService().clearTokens();
    // await DialogUtils.showErrorDialog(
    //   null,
    //   message: AppStrings.dialog_logout_unauthorized_message(),
    // );
    //AppNavigation.goToSplashScreen(null);
  }
}
