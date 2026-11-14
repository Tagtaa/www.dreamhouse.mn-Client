import 'package:auto_route/auto_route.dart';

import '../../init/app_locator.dart';
import '../../services/api/api_service.dart';
import '../../services/app/app_service.dart';
import '../../services/auth/auth_service.dart';
import '../../services/local_storage/local_storage_service.dart';
import '../app_router.dart';

final class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    //final String? serverAddress = "http://10.0.2.2:3000/api";
    final String? serverAddress = await ServiceLocator.get<LocalStorageService>().read(Keys.baseUrl);
    final bool isAuthenticated = await ServiceLocator.get<AuthService>().isAuthenticated();

    if (serverAddress != null && isAuthenticated) {
      _setServerAddress(serverAddress);
      resolver.next(true);
    } else {
      //final String baseUrl = "http://10.0.2.2:3000/api"; //
      final String baseUrl = ServiceLocator.get<AppService>().initialConfig.baseUrl;

      await ServiceLocator.get<LocalStorageService>().write(Keys.baseUrl, baseUrl);
      _setServerAddress(baseUrl);
      //resolver.next(true);

      router.push(const LoginOptionScreenRoute());

      // final List<String> serverAddressList = ServiceLocator.get<AppService>().initialConfig.serverAddresses;

      // router.navigate(
      //   ServerAddressScreenRoute(
      //     args: ServerAddressScreenArgs(
      //       serverAddressList: serverAddressList,
      //       onServerSelected: (String serverAddress) async {
      //         await ServiceLocator.get<LocalStorageService>().write(Keys.baseUrl, serverAddress);
      //         _setServerAddress(serverAddress);

      //         router.push(LoginScreenRoute());
      //       },
      //     ),
      //   ),
      // );
    }
  }

  void _setServerAddress(String serverAddress) {
    ServiceLocator.get<ApiService>().baseUrl = serverAddress;
  }
}
