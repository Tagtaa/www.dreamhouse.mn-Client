// lib/core/utils/form_validators.dart
import '../../configs/constants/text_constants.dart';

class FormValidators {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.validatorPhoneNumberRequired;
    }

    final String cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length != 8) {
      return TextConstants.validatorPhoneNumberLength;
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.validatorUsernameRequired;
    }

    if (value.trim().length < 3) {
      return TextConstants.validatorUsernameMinLength;
    }

    if (value.trim().length > 20) {
      return TextConstants.validatorUsernameMaxLength;
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.validatorEmailRequired;
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return TextConstants.validatorEmailInvalid;
    }

    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.validatorCodeRequired;
    }

    final String cleanCode = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanCode.length != 4) {
      return TextConstants.validatorCodeLength;
    }

    return null;
  }

  static String? validateNumber(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.validatorFieldRequiredWithName(fieldName);
    }

    final double? numericValue = double.tryParse(value.trim());
    if (numericValue == null) {
      return TextConstants.validatorValidNumber;
    }

    if (numericValue <= 0) {
      return TextConstants.validatorNumberGreaterThanZero;
    }

    return null;
  }

  // static String? validateOptionalNumber(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return null;
  //   }

  //   final double? numericValue = double.tryParse(value.trim());
  //   if (numericValue == null) {
  //     return 'Please enter a valid number';
  //   }

  //   if (numericValue <= 0) {
  //     return 'Number must be greater than 0';
  //   }

  //   return null;
  // }
}
