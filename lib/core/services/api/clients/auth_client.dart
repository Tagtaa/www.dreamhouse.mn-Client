import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../configs/constants/text_constants.dart';
import '../../../exceptions/api_exception.dart';
import '../../../models/auth/api/account/user_update_request_model.dart';
import '../../../models/auth/api/login/login_request_model.dart';
import '../../../models/auth/api/auth_response_model.dart';
import '../../../models/auth/api/forgot_password/forgot_password_request_model.dart';
import '../../../models/auth/api/forgot_password/forgot_password_response_model.dart';
import '../../../models/auth/api/me/avatar_upload_response_model.dart';
import '../../../models/auth/api/me/user_model.dart';
import '../../../models/auth/api/reset_password/reset_password_request_model.dart';
import '../../../models/auth/api/reset_password/reset_password_response_model.dart';
import '../../../models/auth/api/send_verify/send_verification_code_request_model.dart';
import '../../../models/auth/api/send_verify/send_verification_code_response_model.dart';
import '../../../models/auth/api/signup/signup_request_model.dart';
import '../../../models/auth/api/subscription/purchase_membership_response_model.dart';
import '../../../models/auth/api/subscription/subscription_response_model.dart';
import '../../../models/result.dart';
import '../constants/api_paths.dart';

final class AuthClient {
  final Dio _api;

  const AuthClient(this._api);

  Future<Result<AuthResponseModel, ApiException>> login(LoginRequestModel requestModel) async {
    try {
      final String number = '${TextConstants.loginPhoneCode}${requestModel.phone}';
      final Response<dynamic> response = await _api.post(
        ApiPaths.login,
        data: <String, dynamic>{
          'phone': number,
          'password': requestModel.password,
        },
      );
      return Success(AuthResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<AuthResponseModel, ApiException>> signUp(SignupRequestModel requestModel) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.signup,
        data: <String, dynamic>{
          'phone': requestModel.phone,
          'password': requestModel.password,
          'username': requestModel.username,
        },
      );
      return Success(AuthResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<Nothing, ApiException>> logout() async {
    try {
      await _api.post(
        ApiPaths.logout,
      );
      return Success.nothing();
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<SendVerificationCodeResponseModel, ApiException>> sendCode(SendVerificationCodeRequestModel requestModel) async {
    try {
      final String number = '${TextConstants.loginPhoneCode}${requestModel.phone}';

      final Response<dynamic> response = await _api.post(
        ApiPaths.sendVerificationCode,
        data: <String, dynamic>{
          'phone': number,
        },
      );

      return Success(SendVerificationCodeResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ForgotPasswordResponseModel, ApiException>> sendForgotPasswordCode(ForgotPasswordCodeRequestModel requestModel) async {
    try {
      final String number = '${TextConstants.loginPhoneCode}${requestModel.phone}';
      final Response<dynamic> response = await _api.post(
        ApiPaths.forgotPassword,
        data: <String, dynamic>{
          'phone': number,
        },
      );
      return Success(ForgotPasswordResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<ResetPasswordResponseModel, ApiException>> sendResetPassword(ResetPasswordRequestModel requestModel) async {
    try {
      final String number = '${TextConstants.loginPhoneCode}${requestModel.phone}';
      final Response<dynamic> response = await _api.post(
        ApiPaths.resetPassword,
        data: <String, dynamic>{
          'phone': number,
          'code': requestModel.code,
          'password': requestModel.password,
        },
      );
      return Success(ResetPasswordResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<String, ApiException>> refreshAccessToken() async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.refreshToken,
      );
      return Success(response.data['access_token']);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<UserResponseModel, ApiException>> getCurrentUser() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.getCurrentUser,
      );
      return Success(UserResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<UserResponseModel, ApiException>> updateUserAccountInfo({required UpdateUserRequestModel model}) async {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (model.email != null && model.email!.trim().isNotEmpty) {
      data.addAll(<String, dynamic>{'email': model.email});
    }

    if (model.username != null && model.username!.trim().isNotEmpty) {
      data.addAll(<String, dynamic>{'username': model.username});
    }

    try {
      final Response<dynamic> response = await _api.put(
        ApiPaths.updateUserAccount,
        data: data,
      );
      return Success(UserResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<AvatarUploadResponseModel, ApiException>> uploadAvatar(Uint8List imageBytes) async {
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'avatar': MultipartFile.fromBytes(
          imageBytes,
          filename: 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final Response<dynamic> response = await _api.post(
        ApiPaths.uploadUserAvatar,
        data: formData,
      );
      return Success(AvatarUploadResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<SubscriptionsResponseModel, ApiException>> getSubscriptions() async {
    final Map<String, dynamic> queryParam = <String, dynamic>{
      'lang': 'mn',
    };
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.subscriptions,
        queryParameters: queryParam,
      );
      return Success(SubscriptionsResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<PurchaseMemberShipResponseModel, ApiException>> postMembership(String subscriptionId) async {
    try {
      final Response<dynamic> response = await _api.post(
        ApiPaths.purchaseMembership,
        data: <String, dynamic>{'subscriptionId': subscriptionId, 'paymentMethod': 'wallet'},
      );
      return Success(PurchaseMemberShipResponseModel.fromJson(response.data));
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<bool, ApiException>> getHealth() async {
    try {
      final Response<dynamic> response = await _api.get(
        ApiPaths.health,
      );
      return const Success(true);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }
}
