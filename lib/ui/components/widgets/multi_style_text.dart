import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_text_styles.dart';

class MultiStyleText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle? firstTextStyle;
  final TextStyle? secondTextStyle;
  final TextAlign? textAlign;

  const MultiStyleText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.firstTextStyle,
    this.secondTextStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,

      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: firstText,
            style: firstTextStyle ?? AppTextStyles.headlineMedium(),
          ),
          TextSpan(
            text: ' $secondText',
            style: secondTextStyle ?? AppTextStyles.headlineLarge(),
          ),
        ],
      ),
    );
  }
}

class TextPart {
  final String text;
  final TextStyle? style;

  TextPart({
    required this.text,
    this.style,
  });
}
