import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/models/rx.dart';
import '../base_screen_controller.dart';
import 'image_picker_screen_args.dart';

final int _kImageQuality = Platform.isIOS ? 5 : 20;

final class ImagePickerScreenController extends BaseScreenController<ImagePickerScreenArgs> {
  final void Function(Uint8List bytes) _onPicked;
  final void Function(String? path) _onPickedPath;
  final Rxn<Uint8List> image;
  final CropController cropController = CropController();

  ImagePickerScreenController(super.args) : _onPicked = args.onPicked, _onPickedPath = args.onPickedPath, image = Rxn<Uint8List>(args.image);

  XFile? xFile;

  @override
  Future<void> onInitState() async {
    super.onInitState();
    if (image() == null) {
      await _pickImageFromCamera();
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      xFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: _kImageQuality,
        preferredCameraDevice: CameraDevice.rear,
      );
      final Uint8List? bytes = await xFile?.readAsBytes();
      image(set: () => bytes);
      if (bytes == null) {
        pop();
      }
    } catch (_) {
      pop();
    }
  }

  void onCropStatusChanged(CropStatus status) => viewState.setBusy(status != CropStatus.ready);
  void onTapCancelButton() => pop();
  void onTapApplyButton() {
    if (image.value != null) {
      pop(() => _onPicked.call(image.value!));
    }
  } //cropController.crop();

  void onCropped(Uint8List croppedImage) => pop(() => _onPicked.call(croppedImage));
  //void onCropped(Uint8List croppedImage) => pop(() => _onPickedPath.call(xFile?.path));
}
