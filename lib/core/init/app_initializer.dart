import 'package:firebase_core/firebase_core.dart';

import 'app_locator.dart';
import 'init_config.dart';

abstract final class AppInitializer {
  static bool _isFirebaseInited = false;

  static Future<void> init() async {
    await _initFirebase();
    await AppLocator.initControllers();
  }

  static Future<void> _initFirebase() async {
    if (!_isFirebaseInited) {
      if (InitConfig.useFirebase) {
        await Firebase.initializeApp();
      }
      _isFirebaseInited = true;
    }
  }
}
