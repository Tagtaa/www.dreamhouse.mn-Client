import 'dart:async';

import '../base_service.dart';
import 'config_key.dart';

abstract base class ConfigService extends BaseService<ConfigService> {
  @override
  Future<ConfigService> init();

  @override
  void dispose();

  T get<T>(ConfigKey<T> config);
}
