import 'package:firebase_core/firebase_core.dart';

import '../configs/constants/text_constants.dart';
import 'firebase_exception.dart';

abstract base class BaseException implements Exception {
  final String _code;
  final String? _messageKey;
  final String? _message;
  final dynamic _e;

  const BaseException({
    required String code,
    String? messageKey,
    String? message,
    dynamic e,
  }) : _code = 'exception_$code',
       _messageKey = messageKey != null ? 'exception_$messageKey' : null,
       _message = message,
       _e = e;

  factory BaseException.from(dynamic e) {
    return switch (e) {
      final BaseException e => e,
      final FirebaseException e => CustomFirebaseException.from(e),
      _ => UnknownException(e: e),
    };
  }

  String get _previewMessage => _message ?? AppStrings.get(_messageKey ?? _code);
  String get message => _previewMessage.isEmpty ? TextConstants.errorNotificationMessage : _previewMessage;
  String get code => _e.response.data['code'];

  @override
  String toString() {
    return <String, dynamic>{
      'code': _code,
      'message': _message,
      'messageKey': _messageKey,
      'e': '$_e',
    }.toString();
  }
}

final class UnknownException extends BaseException {
  const UnknownException({super.e}) : super(code: 'unknown');
}

enum AppStrings {
  // Commons
  common_yes(),
  common_cancel(),
  common_save(),
  common_ok(),
  common_share();

  const AppStrings();

  String call([
    Map<String, dynamic> replaceMap = const <String, dynamic>{},
  ]) {
    String result = get(name);
    replaceMap.forEach((String key, dynamic value) {
      result = result.replaceAll(key, '$value');
    });
    return result;
  }

  static String get(String key) => ''; //;  ServiceLocator.get<LocalizationService>().get(key);
}
