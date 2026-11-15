import 'dart:async';
import 'dart:typed_data';

import '../../exceptions/api_exception.dart';
import '../../models/auth/api/account/user_update_request_model.dart';
import '../../models/auth/api/login/login_request_model.dart';
import '../../models/auth/api/auth_response_model.dart';
import '../../models/auth/api/forgot_password/forgot_password_request_model.dart';
import '../../models/auth/api/forgot_password/forgot_password_response_model.dart';
import '../../models/auth/api/me/avatar_upload_response_model.dart';
import '../../models/auth/api/me/user_model.dart';
import '../../models/auth/api/reset_password/reset_password_request_model.dart';
import '../../models/auth/api/reset_password/reset_password_response_model.dart';
import '../../models/auth/api/send_verify/send_verification_code_request_model.dart';
import '../../models/auth/api/send_verify/send_verification_code_response_model.dart';
import '../../models/auth/api/signup/signup_request_model.dart';
import '../../models/auth/api/subscription/purchase_membership_response_model.dart';
import '../../models/auth/api/subscription/subscription_response_model.dart';
import '../../models/result.dart';
import '../../configs/constants/text_constants.dart';
import '../api/api_service.dart';
import '../base_service.dart';
import '../local_storage/local_storage_service.dart';
import 'token/token_decoder.dart';

final class AuthService extends BaseService<AuthService> {
  final Service<ApiService> _apiService;
  final Service<LocalStorageService> _localStorageService;

  AuthService(
    this._apiService,
    this._localStorageService,
  );

  UserResponseModel? userResponse;
  bool isMember = false;

  /// Deposit bank account shown on the recharge screen (updated from the server).
  String bankAccount = TextConstants.khanBankAccount;

  @override
  Future<AuthService> init() async {
    super.init();
    return this;
  }

  Future<String?> getAccessToken() async {
    final String? accessToken = await _localStorageService().read(Keys.accessToken);
    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      return accessToken;
    }

    final Result<String, ApiException> result = await _apiService().auth.refreshAccessToken();
    return result.on(
      success: (String accessToken) async {
        await _localStorageService().write(Keys.accessToken, accessToken);
        return accessToken;
      },
      failure: (ApiException e) async {
        await clearTokens();
        return null;
      },
    );
  }

  Future<String?> getRefreshToken() async {
    return await _localStorageService().read(Keys.refreshToken);
  }

  Future<bool> isAuthenticated() async {
    final String? refreshToken = await getRefreshToken();
    return refreshToken != null && !JwtDecoder.isExpired(refreshToken);
  }

  Future<Result<Nothing, ApiException>> login({
    required String phone,
    required String password,
  }) async {
    final LoginRequestModel requestModel = LoginRequestModel(
      phone: phone,
      password: password,
    );
    return _apiService().auth.login(requestModel).then(
      (Result<AuthResponseModel, ApiException> response) async {
        return await response.on(
          success: (AuthResponseModel data) async {
            await _localStorageService().write(Keys.accessToken, data.tokenDetails.token);
            await _localStorageService().write(Keys.refreshToken, data.tokenDetails.refreshToken);
            await _localStorageService().writeMap(Keys.userModel, data.user.toJson());
            // await AppAnalytics.setAnalyticsCollectionEnabled(true);
            // await AppAnalytics.logLogin();
            // await AppAnalytics.setUserId(data.user.id);
            // await AppAnalytics.setUserProperty(UserProperty.user_id, data.user.id);
            // await AppAnalytics.setUserProperty(UserProperty.user_rank, data.user.detail.rank);

            return Success.nothing();
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<Nothing, ApiException>> signUp({
    required String phone,
    required String password,
    required String username,
  }) async {
    final SignupRequestModel requestModel = SignupRequestModel(
      phone: phone,
      password: password,
      username: username,
    );
    return _apiService().auth.signUp(requestModel).then(
      (Result<AuthResponseModel, ApiException> response) async {
        return await response.on(
          success: (AuthResponseModel data) async {
            await _localStorageService().write(Keys.accessToken, data.tokenDetails.token);
            await _localStorageService().write(Keys.refreshToken, data.tokenDetails.refreshToken);
            await _localStorageService().writeMap(Keys.userModel, data.user.toJson());
            // await AppAnalytics.setAnalyticsCollectionEnabled(true);
            // await AppAnalytics.logLogin();
            // await AppAnalytics.setUserId(data.user.id);
            // await AppAnalytics.setUserProperty(UserProperty.user_id, data.user.id);
            // await AppAnalytics.setUserProperty(UserProperty.user_rank, data.user.detail.rank);

            return Success.nothing();
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<SendVerificationCodeResponseModel, ApiException>> sendCode({
    required String phone,
  }) async {
    final SendVerificationCodeRequestModel requestModel = SendVerificationCodeRequestModel(
      phone: phone,
    );
    return _apiService().auth.sendCode(requestModel).then(
      (Result<SendVerificationCodeResponseModel, ApiException> response) async {
        return await response.on(
          success: (SendVerificationCodeResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  /// Checks that the SMS parser has received the sign-up [code] for [phone] (+976XXXXXXXX).
  Future<Result<Nothing, ApiException>> verifySignupCode({
    required String phone,
    required String code,
  }) {
    return _apiService().auth.verifyCode(phone: phone, code: code);
  }

  Future<Result<ForgotPasswordResponseModel, ApiException>> sendForgotPasswordCode({
    required String phone,
  }) async {
    final ForgotPasswordCodeRequestModel requestModel = ForgotPasswordCodeRequestModel(
      phone: phone,
    );
    return _apiService().auth.sendForgotPasswordCode(requestModel).then(
      (Result<ForgotPasswordResponseModel, ApiException> response) async {
        return await response.on(
          success: (ForgotPasswordResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<ResetPasswordResponseModel, ApiException>> sendResetPassword({
    required String phone,
    required String code,
    required String password,
  }) async {
    final ResetPasswordRequestModel requestModel = ResetPasswordRequestModel(
      phone: phone,
      code: code,
      password: password,
    );
    return _apiService().auth.sendResetPassword(requestModel).then(
      (Result<ResetPasswordResponseModel, ApiException> response) async {
        return await response.on(
          success: (ResetPasswordResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<UserResponseModel, ApiException>> getCurrentUser() async {
    return await _apiService().auth.getCurrentUser().then(
      (Result<UserResponseModel, ApiException> result) async {
        return await result.on(
          success: (UserResponseModel data) async {
            userResponse = data;
            isMember = data.user?.membership?.type != Member.free;
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<UserResponseModel, ApiException>> updateUserAccountInfo({
    String? username,
    String? email,
  }) async {
    final UpdateUserRequestModel requestModel = UpdateUserRequestModel(
      email: email,
      username: username,
    );
    return _apiService().auth.updateUserAccountInfo(model: requestModel).then(
      (Result<UserResponseModel, ApiException> response) async {
        return await response.on(
          success: (UserResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<AvatarUploadResponseModel, ApiException>> uploadAvatar(Uint8List imageBytes) async {
    return _apiService().auth.uploadAvatar(imageBytes).then(
      (Result<AvatarUploadResponseModel, ApiException> response) async {
        return await response.on(
          success: (AvatarUploadResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<Nothing, ApiException>> logout() async {
    return await _apiService().auth.logout().then(
      (Result<Nothing, ApiException> result) async {
        return await result.on(
          success: (_) async {
            await clearTokens();

            return Success.nothing();
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<SubscriptionsResponseModel, ApiException>> getSubscriptions() async {
    return _apiService().auth.getSubscriptions().then(
      (Result<SubscriptionsResponseModel, ApiException> response) async {
        return await response.on(
          success: (SubscriptionsResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<Result<PurchaseMemberShipResponseModel, ApiException>> postMembership(String subscriptionId) async {
    return _apiService().auth.postMembership(subscriptionId).then(
      (Result<PurchaseMemberShipResponseModel, ApiException> response) async {
        return await response.on(
          success: (PurchaseMemberShipResponseModel data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  /// Latest deposit bank account from the server; keeps the last known one on errors.
  Future<String> loadBankAccount() async {
    final Result<String, ApiException> result = await _apiService().auth.getBankAccount();
    return result.on<String>(
      success: (String account) {
        bankAccount = account;
        return account;
      },
      failure: (_) => bankAccount,
    );
  }

  Future<Result<bool, ApiException>> getHealth() async {
    return _apiService().auth.getHealth().then(
      (Result<bool, ApiException> response) async {
        return await response.on(
          success: (bool data) async {
            return Success(data);
          },
          failure: (ApiException e) => Failure(e),
        );
      },
    );
  }

  Future<void> clearTokens() async {
    await _localStorageService().delete(Keys.accessToken);
    await _localStorageService().delete(Keys.refreshToken);
  }
}
