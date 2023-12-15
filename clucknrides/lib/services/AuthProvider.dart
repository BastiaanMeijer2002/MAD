import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final String _tokenKey = 'jwt_token';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
}
