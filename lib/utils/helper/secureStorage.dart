import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FuzSecureStorageManager {
  //static const _storage = FlutterSecureStorage();
  static const _storage = FlutterSecureStorage( aOptions: AndroidOptions(encryptedSharedPreferences: true) );

  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }


  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  static Future<bool> containsKey(String key) async {
    String? value = await _storage.read(key: key);
    return value != null;
  }
}