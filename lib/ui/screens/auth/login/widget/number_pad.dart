import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/configs/theme/app_text_styles.dart';
import '../../../../../core/utils/extensions/size_extensions.dart';
import '../../../../components/widgets/gesture_detector.dart';

//const double _sizedBoxSize = 70.0;
const double _fontSize = 40.0;
//const double _sizedBoxSmallSize = 35.0;
const double _fontSmallSize = 25.0;

class CustomNumberPad extends StatelessWidget {
  final TextEditingController controller;
  final int maxNumberLength;

  const CustomNumberPad({
    super.key,
    required this.controller,
    required this.maxNumberLength,
  });

  void _addNumber(String number) {
    if (controller.text.length < maxNumberLength) {
      controller.text += number;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  void _backspace() {
    if (controller.text.isNotEmpty) {
      controller.text = controller.text.substring(0, controller.text.length - 1);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> numbers = <List<String>>[
      <String>['1', '2', '3'],
      <String>['4', '5', '6'],
      <String>['7', '8', '9'],
      <String>['', '0', '<'],
    ];

    final bool isSmallScreen = context.isSmallScreen;

    return Padding(
      padding: isSmallScreen ? const EdgeInsets.symmetric(vertical: 15.0) : const EdgeInsets.symmetric(vertical: 30.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxHeight = constraints.maxHeight;
          final double maxWidth = constraints.maxWidth;

          final double containerSize = maxHeight - numbers.length;
          final double containerWidthSize = (maxWidth - (context.screenWidth * 0.3)) / 3;

          return Column(
            mainAxisSize: MainAxisSize.max,
            children: numbers.map((List<String> row) {
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map((String item) {
                    if (item == '') {
                      return SizedBox(
                        width: containerWidthSize,
                        height: containerSize,
                      );
                    } else if (item == '<') {
                      return SizedBox(
                        width: containerWidthSize,
                        height: containerSize,
                        child: CustomGestureDetector(
                          onTap: _backspace,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: AppSize.iconSizeLow,
                              ),
                              if (!isSmallScreen)
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    TextConstants.back,
                                    style: AppTextStyles.labelSmall(color: AppColors.text),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: containerWidthSize,
                        height: containerSize,
                        child: CustomGestureDetector(
                          onTap: () => _addNumber(item),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item,
                                style: AppTextStyles.titleLarge(
                                  fontSize: isSmallScreen ? _fontSmallSize : _fontSize,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
