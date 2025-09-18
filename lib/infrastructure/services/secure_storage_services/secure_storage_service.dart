import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final _storage = const FlutterSecureStorage();

  // Keys
  static const String _tokenKey = 'bearer_token';

  /// Save
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Read
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Delete
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// Clear all
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
