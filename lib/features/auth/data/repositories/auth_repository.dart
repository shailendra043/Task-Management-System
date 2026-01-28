import 'dart:convert';
import 'package:task_app/core/network/api_client.dart';
import 'package:task_app/core/utils/secure_storage_service.dart';
import 'package:task_app/features/auth/data/dtos/auth_dto.dart';
import 'package:task_app/features/auth/domain/models/user_model.dart';

class AuthRepository {

  final SecureStorageService _storage;

  // Mock users database (simulating backend)
  static final List<Map<String, dynamic>> _mockUsers = [];
  static int _userIdCounter = 1;

  AuthRepository({
    ApiClient? apiClient,
    SecureStorageService? storage,
  })  : _storage = storage ?? SecureStorageService();

  /// Login with email and password
  /// In production, this would call the API endpoint
  /// For now, we use mock data
  Future<AuthResponseDto> login(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Find user in mock database
    final userMap = _mockUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => throw Exception('Invalid email or password'),
    );

    // Create user model
    final user = UserModel(
      id: userMap['id'].toString(),
      name: userMap['name'],
      email: userMap['email'],
      createdAt: DateTime.parse(userMap['createdAt']),
    );

    // Generate mock tokens
    final accessToken = _generateMockToken(user.id);
    final refreshToken = _generateMockToken(user.id, isRefresh: true);

    // Store tokens
    await _storage.saveAccessToken(accessToken);
    await _storage.saveRefreshToken(refreshToken);
    await _storage.saveUserData(jsonEncode(user.toJson()));

    return AuthResponseDto(
      user: user,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Register new user
  /// In production, this would call the API endpoint
  Future<AuthResponseDto> register(
    String name,
    String email,
    String password,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if email already exists
    final exists = _mockUsers.any((user) => user['email'] == email);
    if (exists) {
      throw Exception('Email already registered');
    }

    // Create new user
    final userId = _userIdCounter++;
    final userMap = {
      'id': userId,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': DateTime.now().toIso8601String(),
    };
    _mockUsers.add(userMap);

    // Create user model
    final user = UserModel(
      id: userId.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    // Generate mock tokens
    final accessToken = _generateMockToken(user.id);
    final refreshToken = _generateMockToken(user.id, isRefresh: true);

    // Store tokens
    await _storage.saveAccessToken(accessToken);
    await _storage.saveRefreshToken(refreshToken);
    await _storage.saveUserData(jsonEncode(user.toJson()));

    return AuthResponseDto(
      user: user,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Refresh access token using refresh token
  Future<RefreshTokenResponseDto> refreshToken() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    // In production, validate refresh token with backend
    // For now, generate new tokens
    final userDataStr = await _storage.getUserData();
    if (userDataStr == null) {
      throw Exception('User data not found');
    }

    final userData = jsonDecode(userDataStr);
    final userId = userData['id'].toString();

    final newAccessToken = _generateMockToken(userId);
    final newRefreshToken = _generateMockToken(userId, isRefresh: true);

    await _storage.saveAccessToken(newAccessToken);
    await _storage.saveRefreshToken(newRefreshToken);

    return RefreshTokenResponseDto(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );
  }

  /// Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    final userDataStr = await _storage.getUserData();
    if (userDataStr == null) return null;

    try {
      final userData = jsonDecode(userDataStr);
      return UserModel.fromJson(userData);
    } catch (_) {
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await _storage.isLoggedIn();
  }

  /// Logout - clear all stored data
  Future<void> logout() async {
    await _storage.clearAll();
  }

  /// Generate mock JWT-like token
  String _generateMockToken(String userId, {bool isRefresh = false}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final type = isRefresh ? 'refresh' : 'access';
    return 'mock_${type}_token_${userId}_$timestamp';
  }
}
