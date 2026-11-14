import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/models/rx.dart';
import '../../components/buttons/custom_buttons.dart';
import '../../components/widgets/obx.dart';
import '../base_screen_view.dart';
import 'image_picker_screen_args.dart';
import 'image_picker_screen_controller.dart';

@RoutePage()
final class ImagePickerScreenView extends BaseScreenView<ImagePickerScreenController, ImagePickerScreenArgs> {
  const ImagePickerScreenView({
    super.key,
    required super.args,
  });

  @override
  State<ImagePickerScreenView> createState() => _ImagePickerScreenViewState();
}

final class _ImagePickerScreenViewState extends BaseScreenViewState<ImagePickerScreenView, ImagePickerScreenController, ImagePickerScreenArgs> {
  @override
  Scaffold builder(BuildContext context, ImagePickerScreenController controller) {
    final Widget hint = Container(
      padding: const EdgeInsets.all(AppSize.padding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //AppIcons.crop(color: AppColors.onSurfaceMedium),
          const SizedBox(width: AppSize.padding),
          Flexible(
            child: Text(
              'AppStrings.image_picker_hint()',
              style: AppTextStyles.bodyMedium(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    final Widget image = Obx(
      controller.image,
      builder: (BuildContext context, Rxn<Uint8List> image, _) {
        return switch (image()) {
          final Uint8List image =>
            // Crop(
            //   image: image,
            //   controller: controller.cropController,
            //   onCropped: controller.onCropped,
            //   interactive: true,
            //   withCircleUi: true,
            //   fixArea: false,
            //   aspectRatio: _kCropAspectRatio,
            //   initialSize: _kCropWidthFactor,
            //   baseColor: Colors.black,
            //   maskColor: Colors.black.withOpacity(_kCropMaskOpacity),
            //   onStatusChanged: controller.onCropStatusChanged,
            // ),
            Image.memory(image),
          _ => const SizedBox(),
        };
      },
    );

    final Widget buttons = Padding(
      padding: const EdgeInsets.all(AppSize.padding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomButton(
              text: TextConstants.cancel,
              type: ButtonType.customPrimarySmall,
              backgroundColor: AppColors.onPrimary,
              textStyle: AppTextStyles.buttonText(color: AppColors.secondary),
              onTap: () => controller.onTapCancelButton(),
            ),
          ),
          const SizedBox(width: AppSize.padding),
          Expanded(
            child: CustomButton(
              text: TextConstants.continueText,
              type: ButtonType.customPrimarySmall,
              onTap: () => controller.onTapApplyButton(),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      //appBar: appBar,
      body: Column(
        children: <Widget>[
          hint,
          Expanded(child: image),
          buttons,
        ],
      ),
    );
  }
}
