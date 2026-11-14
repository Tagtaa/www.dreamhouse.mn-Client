import 'dart:io';

import 'package:dio/dio.dart';

import 'base_exception.dart';

abstract base class ApiException extends BaseException {
  const ApiException({
    required String code,
    String? messageKey,
    super.message,
    super.e,
  }) : super(
         code: 'api_$code',
         messageKey: messageKey != null ? 'api_$messageKey' : null,
       );

  factory ApiException.from(dynamic e) {
    ApiException handleDioException(DioException e) {
      switch (e.type) {
        case DioExceptionType.cancel:
          return RequestCancelException(e: e);
        case DioExceptionType.badCertificate:
          return BadCertificateException(e: e);
        case DioExceptionType.connectionError:
          return ConnectionException(e: e);
        case DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout:
          return TimeoutException(e: e);
        case DioExceptionType.connectionTimeout:
          return ConnectionTimeoutException(e: e);
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400 || 401 || 403:
              return UnauthorizedException(e: e);
            case 404:
              return NotFoundException(e: e);
            case 408:
              return TimeoutException(e: e);
            case 409:
              return ConflictException(e: e);
            case 500:
              return InternalServerException(e: e);
            case 503:
              return ServiceUnavailableException(e: e);
          }
        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            return NoInternetConnectionException(e: e);
          }
      }
      return UnknownException(e: e);
    }

    return switch (e) {
      ApiException _ => e,
      DioException _ => handleDioException(e),
      _ => UnknownException(e: e),
    };
  }
}

final class BadCertificateException extends ApiException {
  BadCertificateException({super.e})
    : super(
        code: 'bad_certificate',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class ConflictException extends ApiException {
  ConflictException({super.e})
    : super(
        code: 'conflict',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class ConnectionException extends ApiException {
  ConnectionException({super.e})
    : super(
        code: 'connection',
        message: _extractBackendMessage(e),
      );
}

final class InternalServerException extends ApiException {
  InternalServerException({super.e})
    : super(
        code: 'internal_server_error',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException({super.e})
    : super(
        code: 'no_internet_connection',
        message: _extractBackendMessage(e),
      );
}

final class NotFoundException extends ApiException {
  NotFoundException({super.e})
    : super(
        code: 'not_found',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class RequestCancelException extends ApiException {
  RequestCancelException({super.e})
    : super(
        code: 'request_cancel',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException({super.e})
    : super(
        code: 'service_unavailable',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

final class TimeoutException extends ApiException {
  TimeoutException({super.e})
    : super(
        code: 'timeout',
        message: _extractBackendMessage(e),
      );
}

final class ConnectionTimeoutException extends ApiException {
  ConnectionTimeoutException({super.e})
    : super(
        code: 'connection_timeout',
        message: _extractBackendMessage(e),
      );
}

final class UnauthorizedException extends ApiException {
  UnauthorizedException({required super.e})
    : super(
        code: 'unauthorised',
        message: _extractBackendMessage(e),
      );
}

final class UnknownException extends ApiException {
  UnknownException({super.e})
    : super(
        code: 'unknown',
        messageKey: 'unknown',
        message: _extractBackendMessage(e),
      );
}

String? _extractBackendMessage(dynamic e) {
  if (e is DioException && e.response?.data != null && e.response!.data is Map<String, dynamic>) {
    final Map<String, dynamic> data = e.response!.data as Map<String, dynamic>;

    if (data['errors'] is List && data['errors'].isNotEmpty) {
      final firstError = data['errors'].first;
      if (firstError is Map && firstError['msg'] is String) {
        return firstError['msg'] as String;
      }
    }
    if (data['message'] is String) {
      return data['message'] as String;
    }
  }
  return null;
}
