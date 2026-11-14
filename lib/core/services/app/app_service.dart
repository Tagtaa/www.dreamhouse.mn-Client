import '../../models/initial_config/initial_config_model.dart';
import '../base_service.dart';
import '../config/config_key.dart';
import '../config/config_service.dart';

final class AppService extends BaseService<AppService> {
  final InitialConfigModel initialConfig;

  AppService(Service<ConfigService> configService)
    : initialConfig = InitialConfigModel.fromJson(
        configService().get(ConfigKey.initialConfig),
      );
}
