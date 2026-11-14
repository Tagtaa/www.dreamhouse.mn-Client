// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/configs/theme/app_text_styles.dart';

const double _radiusSize = 8.0;
const double _emptySize = 4.0;
const double _padding = 15.0;
const double _fontSize = 8.0;
const double _iconSize = 8.0;

class ScoreAndFavoriteView extends StatelessWidget {
  const ScoreAndFavoriteView({
    super.key,
    this.iconSize = _iconSize,
    this.radiusSize = _radiusSize,
    this.fontSize = _fontSize,
    this.padding = AppSize.paddingLow,
    this.leftPadding,
    this.rightPadding,
    this.bottomPadding,
    this.topPadding,
    required this.like,
    required this.rating,
  });

  final double iconSize;
  final double radiusSize;
  final double fontSize;
  final double padding;
  final double? leftPadding;
  final double? rightPadding;
  final double? bottomPadding;
  final double? topPadding;
  final int like;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: leftPadding,
      right: rightPadding,
      bottom: bottomPadding,
      top: topPadding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.reviewContainer,
          borderRadius: BorderRadius.circular(radiusSize),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: AppColors.star,
                size: fontSize,
              ),
              const SizedBox(width: _emptySize),
              Text(
                rating.toString(),
                style: AppTextStyles.titleMedium(
                  fontSize: fontSize,
                  color: AppColors.buttonText,
                ),
              ),

              const SizedBox(width: _padding),

              Icon(
                Icons.favorite,
                color: AppColors.favorite,
                size: fontSize,
              ),
              const SizedBox(width: _emptySize),
              Text(
                like.toString(),
                style: AppTextStyles.titleMedium(
                  fontSize: fontSize,
                  color: AppColors.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
