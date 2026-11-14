import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/utils/extensions/size_extensions.dart';

const double _borderWidth = 1.6;
const double _margin = 1.6;
const double _widthRate = 0.65;

class CustomSizeEntryTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String sizeTitle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomSizeEntryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sizeTitle,
    this.onChanged,
    this.validator,
  });

  @override
  _CustomSizeEntryTextFieldState createState() => _CustomSizeEntryTextFieldState();
}

class _CustomSizeEntryTextFieldState extends State<CustomSizeEntryTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

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
    return Container(
      margin: EdgeInsets.all(_isFocused ? _margin : 0),
      child: Padding(
        padding: const EdgeInsets.only(left: AppSize.padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSize.paddingHigh),
              child: Text(widget.sizeTitle, style: AppTextStyles.bodyMedium()),
            ),
            SizedBox(
              width: context.dw(_widthRate),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    controller: widget.controller,
                    focusNode: _focusNode,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: widget.onChanged,
                    validator: (String? value) {
                      final String? validationResult = widget.validator?.call(value);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _errorText = validationResult;
                          });
                        }
                      });
                      return validationResult;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              TextConstants.cm,
                              style: AppTextStyles.titleLarge(color: AppColors.text),
                            ),
                          ],
                        ),
                      ),
                      hintText: widget.hintText,
                      hintStyle: AppTextStyles.titleLarge(color: AppColors.hintText, fontSize: AppSize.bodyFontSize),
                      filled: true,
                      fillColor: AppColors.secondaryBackground,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSize.paddingHigh,
                        horizontal: AppSize.padding,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.radiusLow),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.radiusLow),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.radiusLow),
                        borderSide: const BorderSide(color: AppColors.error, width: _borderWidth),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.radiusLow),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                    ),
                    style: AppTextStyles.titleLarge(color: AppColors.text),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                  ),
                  if (_errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _errorText!,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.labelSmall(color: AppColors.error),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
