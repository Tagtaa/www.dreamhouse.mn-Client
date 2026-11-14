import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../base_service.dart';

enum Keys {
  accessToken,
  refreshToken,
  baseUrl,
  sessionId,
  userModel,
  userRights,
  notificationType,
  hasSeenOnboarding,
}

final class LocalStorageService extends BaseService<LocalStorageService> {
  final FlutterSecureStorage _storage;

  LocalStorageService()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        // iOptions: IOSOptions(
        //   groupId: 'group.tr.com.dream.house.custom-notification-service',
        //   accountName: 'group.tr.com.dream.house.custom-notification-service',
        //   synchronizable: false,
        //   accessibility: KeychainAccessibility.unlocked,
        // ),
      );

  Future<String?> read(Keys key) async {
    return await _storage.read(key: key.name);
  }

  Future<Map<String, dynamic>?> readMap(Keys key) async {
    final String? value = await read(key);
    return value != null ? jsonDecode(value) : null;
  }

  Future<List<dynamic>?> readList(Keys key) async {
    final String? value = await read(key);
    return value != null ? jsonDecode(value) : null;
  }

  Future<void> write(Keys key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  Future<void> writeMap(Keys key, Map<String, dynamic> value) async {
    await write(key, jsonEncode(value));
  }

  Future<void> writeList(Keys key, List<dynamic> value) async {
    await write(key, jsonEncode(value));
  }

  Future<void> delete(Keys key) async {
    await _storage.delete(key: key.name);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
