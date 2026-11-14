import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/configs/constants/text_constants.dart';
import 'core/configs/theme/app_theme.dart';
import 'core/init/app_initializer.dart';
import 'core/routing/app_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppInitializer.init();
  runApp(const MyApp());

  // runApp(
  //   DevicePreview(
  //     enabled: true, //!kReleaseMode,
  //     builder: (BuildContext context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.unfocus(),
      child: MaterialApp.router(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        title: TextConstants.appName,
        themeMode: AppTheme.themeMode,
        theme: AppTheme.lightTheme,
        routerConfig: AppNavigation.routerConfig,
      ),
    );
  }
}
