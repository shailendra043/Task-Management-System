import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_app/core/constants/api_constants.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: ApiConstants.accessTokenKey,
      value: token,
    );
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.accessTokenKey);
  }

  // Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(
      key: ApiConstants.refreshTokenKey,
      value: token,
    );
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.refreshTokenKey);
  }

  // Save user data as JSON string
  Future<void> saveUserData(String userData) async {
    await _storage.write(
      key: ApiConstants.userDataKey,
      value: userData,
    );
  }

  // Get user data
  Future<String?> getUserData() async {
    return await _storage.read(key: ApiConstants.userDataKey);
  }

  // Clear all stored data (for logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
