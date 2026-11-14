import 'dart:typed_data';

import '../base_screen_args.dart';

final class ImagePickerScreenArgs extends BaseScreenArgs {
  final Uint8List? image;
  final void Function(Uint8List bytes) onPicked;
  final void Function(String? path) onPickedPath;

  const ImagePickerScreenArgs({
    this.image,
    required this.onPicked,
    required this.onPickedPath,
  });
}
