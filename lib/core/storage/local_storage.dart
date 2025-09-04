import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trailo_pro/core/constants/api_constants.dart';
import 'package:trailo_pro/core/constants/app_constants.dart';
import 'package:trailo_pro/core/constants/storage_keys.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? userId,
  }) async {
    await Future.wait(<Future<void>>[
      _storage.write(key: StorageKeys.accessToken, value: accessToken),
      _storage.write(key: StorageKeys.refreshToken, value: refreshToken),
      if (userId != null) _storage.write(key: StorageKeys.userProfile, value: userId),
    ]);
  }
  
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: StorageKeys.accessToken);
  }
  
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: StorageKeys.refreshToken);
  }
  
  static Future<String?> getUserId() async {
    return await _storage.read(key: StorageKeys.userProfile);
  }
  
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}