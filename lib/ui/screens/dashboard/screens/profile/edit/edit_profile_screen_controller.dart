import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../../core/configs/constants/app_images.dart';
import '../../../../../../core/configs/constants/text_constants.dart';
import '../../../../../../core/exceptions/api_exception.dart';
import '../../../../../../core/models/auth/api/me/avatar_upload_response_model.dart';
import '../../../../../../core/models/auth/api/me/user_model.dart';
import '../../../../../../core/models/result.dart';
import '../../../../../../core/routing/app_navigation.dart';
import '../../../../../../core/services/auth/auth_service.dart';
import '../../../../../components/overlay/alert_notification_overlay.dart';
import '../../../../base_screen_args.dart';
import '../../../../base_screen_controller.dart';
import '../../../../image_picker/image_picker_screen_args.dart';

final class EditProfileScreenController extends BaseScreenController<DefaultScreenArgs> {
  final Service<AuthService> _authService;

  EditProfileScreenController(
    super.args,
    this._authService,
  );

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserResponseModel? user;
  Uint8List? pickedImage;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    user = _authService().userResponse;
    usernameController.text = user?.user?.username ?? '';
    emailController.text = user?.user?.email ?? '';
  }

  Future<void> onSave() async {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      viewState.setBusy(true);

      await _authService().updateUserAccountInfo(email: emailController.text, username: usernameController.text).then(
        (Result<UserResponseModel, ApiException> result) {
          result.on(
            success: (UserResponseModel result) async {
              //_authService().getCurrentUser();
              await showAlertNotification(context(), message: TextConstants.editSuccessful, icon: AppImages.success_alert());
              AppNavigation.popRoute(context());
            },
            failure: (ApiException e) async {
              await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
            },
          );
        },
      );

      viewState.setBusy(false);
    }
  }

  void onTapImage() {
    AppNavigation.goToImagePicker(
      context(),
      args: ImagePickerScreenArgs(
        onPicked: (Uint8List bytes) {
          pickedImage = bytes;
          print(bytes);
          updateUserAvatar();
        },
        onPickedPath: (String? path) {
          print(path);
        },
      ),
    );
  }

  Future<void> updateUserAvatar() async {
    if (pickedImage == null) {
      return;
    }
    viewState.setBusy(true);

    await _authService().uploadAvatar(pickedImage!).then(
      (Result<AvatarUploadResponseModel, ApiException> result) {
        result.on(
          success: (AvatarUploadResponseModel result) async {
            _authService().getCurrentUser();
            await showAlertNotification(context(), message: TextConstants.editSuccessful, icon: AppImages.success_alert());
            AppNavigation.popRoute(context());
          },
          failure: (ApiException e) async {
            await showAlertNotification(context(), message: e.message, icon: AppImages.warning_alert());
          },
        );
      },
    );

    viewState.setBusy(false);
  }
}
