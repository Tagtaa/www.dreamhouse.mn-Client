import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'config_key.dart';
import 'config_service.dart';

const Duration _kFetchTimeout = Duration(minutes: 1);
const Duration _kMinimumFetchInterval = Duration(seconds: 1);

final class RemoteConfigService extends ConfigService {
  StreamSubscription<RemoteConfigUpdate>? _configChangesSubscription;

  @override
  Future<RemoteConfigService> init() async {
    super.init();

    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: _kFetchTimeout,
        minimumFetchInterval: _kMinimumFetchInterval,
      ),
    );
    await FirebaseRemoteConfig.instance.fetchAndActivate();

    _configChangesSubscription = FirebaseRemoteConfig.instance.onConfigUpdated.listen(
      (RemoteConfigUpdate event) => FirebaseRemoteConfig.instance.fetchAndActivate(),
    );
    return this;
  }

  @override
  void dispose() {
    _configChangesSubscription?.cancel();
    super.dispose();
  }

  @override
  T get<T>(ConfigKey<T> config) {
    final RemoteConfigValue remoteConfigValue = FirebaseRemoteConfig.instance.getValue(config.key);

    return switch (config.valueType) {
          ValueType.INT => remoteConfigValue.asInt(),
          ValueType.DOUBLE => remoteConfigValue.asDouble(),
          ValueType.BOOL => remoteConfigValue.asBool(),
          ValueType.STRING => remoteConfigValue.asString(),
          ValueType.LIST => jsonDecode(remoteConfigValue.asString()),
          ValueType.MAP => jsonDecode(remoteConfigValue.asString()),
        }
        as T;
  }
}
