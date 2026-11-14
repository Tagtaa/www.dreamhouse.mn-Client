import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_icons.dart';
import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/utils/extensions/size_extensions.dart';

const double _borderWidth = 1.6;
const double _margin = 1.6;
const double _containerHeight = 30.0;
const double _containerWidthRate = 1;

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color backgroundColor;
  final bool isMaterialField;
  final AppIcons suffixIcon;
  final AppIcons? prefixIcon;
  final Color? iconColor;
  final bool isShowSuffixIcon;
  final double radius;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final TextInputType keyboardType;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isMaterialField = false,
    this.suffixIcon = AppIcons.search,
    this.prefixIcon,
    this.backgroundColor = AppColors.secondaryBackground,
    this.iconColor,
    this.isShowSuffixIcon = true,
    this.radius = AppSize.radius,
    this.onTap,
    this.onChanged,
    this.validator,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: AppSize.durationLowest),
      margin: EdgeInsets.all(_isFocused ? _margin : AppSize.paddingZero),
      child: TextField(
        onTap: widget.onTap,
        readOnly: widget.isReadOnly,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: switch (widget.prefixIcon != null) {
            true => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
              child: widget.prefixIcon?.call(color: widget.iconColor ?? AppColors.onSurface, applyColorFilter: true),
            ),
            false => null,
          },

          suffixIcon: switch (widget.isShowSuffixIcon) {
            true => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!widget.isMaterialField) ...<Widget>[
                    Container(
                      width: _containerWidthRate,
                      height: _containerHeight,
                      color: AppColors.onTertiary,
                    ),
                    const SizedBox(width: AppSize.emptySizeLow),
                  ],
                  widget.suffixIcon(
                    color: widget.iconColor != null
                        ? widget.iconColor!
                        : widget.isMaterialField
                        ? AppColors.onSecondary
                        : AppColors.ideaIcon,
                    applyColorFilter: true,
                  ),
                ],
              ),
            ),
            false => null,
          },

          hintText: widget.hintText,
          hintTextDirection: TextDirection.ltr,
          hintStyle: AppTextStyles.titleLarge(
            color: AppColors.onTertiary,
            fontSize: AppSize.labelFontSize,
            fontFamily: fontFamilyRaleway,
          ),
          counterText: '',
          filled: true,
          fillColor: widget.backgroundColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: context.isSmallScreen ? AppSize.zero : AppSize.padding,
            horizontal: AppSize.padding,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(color: AppColors.error, width: _borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide.none,
          ),
        ),
        style: AppTextStyles.titleLarge(color: AppColors.onSecondary),
      ),
    );
  }
}
