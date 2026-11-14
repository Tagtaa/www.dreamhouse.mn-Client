import 'dart:io';

class AppConfig {
  // App Configuration
  static const String appVersion = '1.0.0';
  static const String appName = 'SMS Parser';

  // SMS Parser Configuration
  static const String defaultBankName = 'Khan Bank';
  static const String defaultCurrency = 'MNT';

  // API Timeouts
  static const int connectionTimeoutSeconds = 15;
  static const int receiveTimeoutSeconds = 15;
  static const int sendTimeoutSeconds = 60;

  // Environment detection
  //  static bool get isDevelopment => baseUrl.contains('localhost') || baseUrl.contains('10.0.2.2');
  //static bool get isProduction => !isDevelopment;

  // Platform info
  static String get platformInfo {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }
}
