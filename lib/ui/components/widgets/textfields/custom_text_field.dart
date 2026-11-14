import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/text_constants.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/utils/extensions/size_extensions.dart';

const double _margin = 1.6;

class _CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String countryCode;
  final bool isPHoneField;
  final int? numberMaxLimit;
  final void Function(String)? onChanged;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool readOnly;

  const _CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.countryCode = TextConstants.loginPhoneCode,
    this.isPHoneField = false,
    this.numberMaxLimit,
    this.onChanged,
    this.textInputType = TextInputType.number,
    this.validator,
    this.readOnly = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;
  String _previousText = '';
  String? get errorText => _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // _focusNode.addListener(_onFocusChange);

    widget.controller.addListener(_onTextControllerChanged);
    _previousText = widget.controller.text;

    _isFocused = true;
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = true;
      if (_isFocused && _errorText != null) {
        _errorText = null;
      }
    });
  }

  void _onTextControllerChanged() {
    final String currentText = widget.controller.text;
    if (currentText != _previousText && _errorText != null) {
      setState(() {
        _errorText = null;
      });
    }
    _previousText = currentText;
    widget.onChanged?.call(currentText);
  }

  // void validateField() {
  //   setState(() {
  //     _shouldValidate = true;
  //   });

  //   final String? validationResult = widget.validator?.call(widget.controller.text);
  //   setState(() {
  //     _errorText = validationResult;
  //     _shouldValidate = false;
  //   });
  // }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_onTextControllerChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: AppSize.durationLowest),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-0.8, -0.8),
              end: Alignment(0.8, 0.8),
              colors: <Color>[
                AppColors.primary,
                AppColors.onSurface,
              ],
              stops: <double>[-1.0235, 0.895],
            ),
            borderRadius: BorderRadius.circular(AppSize.radiusLowest),
          ),
          child: Container(
            margin: const EdgeInsets.all(_margin),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(AppSize.radiusLowest),
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              readOnly: widget.readOnly,
              controller: widget.controller,
              //focusNode: _focusNode,
              keyboardType: widget.textInputType,
              maxLength: widget.numberMaxLimit,
              //onChanged: null,
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
                prefixIcon: widget.isPHoneField
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              Icons.phone,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: AppSize.paddingLow),
                            Text(
                              widget.countryCode,
                              style: AppTextStyles.titleLarge(color: AppColors.text),
                            ),
                          ],
                        ),
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: AppTextStyles.titleLarge(color: AppColors.hintText),
                counterText: '',
                filled: true,
                fillColor: AppColors.secondaryBackground,
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.isSmallScreen ? AppSize.zero : AppSize.paddingNormal,
                  horizontal: AppSize.paddingLow,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                  //borderSide: BorderSide(color: Colors.black26, width: _borderWidth),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusLowest),
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(height: 0, fontSize: 0),
              ),
              style: AppTextStyles.titleLarge(color: AppColors.text),
            ),
          ),
        ),
        const SizedBox(height: AppSize.emptySizeLowest),
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
    );
  }
}

class PhoneTextField extends _CustomTextField {
  const PhoneTextField({
    super.key,
    required super.controller,
    required super.hintText,
    super.validator,
    super.onChanged,
    super.countryCode = TextConstants.loginPhoneCode,
  }) : super(
         numberMaxLimit: AppSize.phoneNumberMaxLimit,
         isPHoneField: true,
         textInputType: TextInputType.phone,
         readOnly: true,
       );
}

class PasswordTextField extends _CustomTextField {
  const PasswordTextField({
    super.key,
    required super.controller,
    required super.hintText,
    super.validator,
    super.onChanged,
  }) : super(
         numberMaxLimit: AppSize.phoneCodeNumberMaxLimit,
         readOnly: true,
       );
}

class NameTextField extends _CustomTextField {
  const NameTextField({
    super.key,
    required super.controller,
    required super.hintText,
    super.validator,
    super.onChanged,
  }) : super(
         textInputType: TextInputType.text,
       );
}
