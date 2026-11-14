import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../auth/auth_service.dart';
import '../base_service.dart';
import 'clients/anonymous_message_client.dart';
import 'clients/auth_client.dart';
import 'clients/calculation_client.dart';
import 'clients/idea_client.dart';
import 'clients/material_client.dart';
import 'clients/message_client.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/token_interceptor.dart';

final class ApiService extends BaseService<ApiService> {
  final dio.Dio _api;
  late final AuthClient auth;
  late final MaterialClient material;
  late final IdeaClient idea;
  late final CalculationClient calculation;
  late final MessageClient message;
  late final AnonymousMessageClient anonymousMessage;

  ApiService(Service<AuthService> authService)
    : _api =
          dio.Dio(
              dio.BaseOptions(
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                sendTimeout: const Duration(seconds: 15),
                headers: <String, dynamic>{
                  //HttpHeaders.contentTypeHeader: ContentType.json.value,
                  HttpHeaders.acceptLanguageHeader: 'mn', //Intl.shortLocale(Intl.getCurrentLocale()),
                },
              ),
            )
            ..interceptors.addAll(
              <dio.Interceptor>[
                CacheInterceptor(),
                TokenInterceptor(authService),
                if (kDebugMode) LoggingInterceptor(),
              ],
            ) {
    auth = AuthClient(_api);
    material = MaterialClient(_api);
    idea = IdeaClient(_api);
    calculation = CalculationClient(_api);
    message = MessageClient(_api);
    anonymousMessage = AnonymousMessageClient(_api);
  }

  set baseUrl(String baseUrl) => _api.options.baseUrl = baseUrl;
  String get baseUrl => _api.options.baseUrl;
}

final class CancelToken extends dio.CancelToken {}
