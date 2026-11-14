// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/constants/app_images.dart';
import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/constants/text_constants.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/routing/app_navigation.dart';
import '../../screens/dashboard/screens/home/choose_material/choose_material_screen_args.dart';
import '../../screens/dashboard/screens/home/choose_shapes/choose_shapes_screen_args.dart';
import '../../screens/dashboard/screens/home/choose_thickness/choose_thickness_screen_args.dart';
import '../../screens/dashboard/screens/home/choose_type/choose_type_screen_args.dart';
import '../../screens/dashboard/screens/home/model/choose_material_model.dart';
import '../../screens/dashboard/screens/home/model/choose_shape_model.dart';
import '../../screens/dashboard/screens/home/model/choose_thickness_model.dart';
import '../../screens/dashboard/screens/home/model/choose_type_model.dart';
import 'gesture_detector.dart';

class ChooseTypeButton extends StatelessWidget {
  const ChooseTypeButton({
    super.key,
    this.isLeftAlignText = false,
    this.chooseTypeModel,
    this.chooseMaterialModel,
    this.chooseThicknessModel,
    this.chooseShapeModel,
  });

  final bool isLeftAlignText;
  final ChooseTypeModel? chooseTypeModel;
  final ChooseMaterialModel? chooseMaterialModel;
  final ChooseThicknessModel? chooseThicknessModel;
  final ChooseShapeModel? chooseShapeModel;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
        if (chooseMaterialModel != null) {
          AppNavigation.gotoChooseMaterialRoute(
            context,
            args: ChooseMaterialScreenArgs(
              material: chooseMaterialModel?.type ?? '',
              onItemTap: chooseMaterialModel?.onItemTap,
            ),
          );
        } else if (chooseTypeModel != null) {
          AppNavigation.gotoChooseTypeRoute(
            context,
            args: ChooseTypeScreenArgs(
              type: chooseTypeModel?.type ?? '',
              isLeftAlignText: isLeftAlignText,
              onItemTap: chooseTypeModel?.onItemTap,
            ),
          );
        } else if (chooseThicknessModel != null) {
          AppNavigation.gotoChooseThicknessRoute(
            context,
            args: ChooseThicknessScreenArgs(
              onItemTap: chooseThicknessModel?.onItemTap,
            ),
          );
        } else if (chooseShapeModel != null) {
          AppNavigation.gotoChooseShapeRoute(
            context,
            args: ChooseShapesScreenArgs(
              onItemTap: chooseShapeModel?.onItemTap,
            ),
          );
        }
      },
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          //height: context.dh(context.heightTypeRate),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.radius),
            color: AppColors.customButton,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppIcons.choose(size: AppSize.iconSizeNormal),
                const SizedBox(
                  height: AppSize.emptySizeLowest,
                ),
                Text(
                  TextConstants.choose,
                  style: AppTextStyles.bodyMedium(color: AppColors.onPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageTypeShow extends StatelessWidget {
  const ImageTypeShow({
    super.key,
    this.image,
  });

  final AppImages? image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        //height: context.dh(context.heightTypeRate),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.radius),
          color: AppColors.secondaryBackground,
        ),
        //child:
        //  ClipRRect(
        //   borderRadius: BorderRadius.circular(AppSize.radius),
        //   child: switch (image != null) {
        //     true => image!(fit: BoxFit.contain),
        //     false => null,
        //   },
        // ),
      ),
    );
  }
}
