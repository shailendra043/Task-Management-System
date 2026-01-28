import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/core/network/api_client.dart';
import 'package:task_app/core/utils/secure_storage_service.dart';
import 'package:task_app/features/auth/data/dtos/auth_dto.dart';
import 'package:task_app/features/auth/domain/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthRepository {

  final SecureStorageService _storage;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
    ApiClient? apiClient,
    SecureStorageService? storage,
    FirebaseAuth? firebaseAuth,
  })  : _storage = storage ?? SecureStorageService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Login with email and password
  Future<AuthResponseDto> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Login failed: User is null');
      }

      final idToken = await user.getIdToken();
      if (idToken == null) {
        throw Exception('Login failed: Failed to get access token');
      }

      // Convert Firebase User to UserModel
      final userModel = UserModel(
        id: user.uid,
        name: user.displayName ?? 'User', // Fallback name
        email: user.email ?? email,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );

      // Store tokens and user data
      await _storage.saveAccessToken(idToken);
      // Firebase handles refresh token internally, but we can store the uid for persistence check
      await _storage.saveRefreshToken(user.uid); 
      await _storage.saveUserData(jsonEncode(userModel.toJson()));

      return AuthResponseDto(
        user: userModel,
        accessToken: idToken,
        refreshToken: user.uid, // Using uid as pseudo-refresh token for local consistency
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  /// Register new user
  Future<AuthResponseDto> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Registration failed: User is null');
      }

      // Update display name
      await user.updateDisplayName(name);
      await user.reload(); // Reload to get updated data
      final updatedUser = _firebaseAuth.currentUser; 

      final idToken = await updatedUser?.getIdToken();
      if (idToken == null) {
         throw Exception('Registration failed: Failed to get access token');
      }

      final userModel = UserModel(
        id: updatedUser!.uid,
        name: name,
        email: updatedUser.email ?? email,
        createdAt: updatedUser.metadata.creationTime ?? DateTime.now(),
      );

      // Store tokens
      await _storage.saveAccessToken(idToken);
      await _storage.saveRefreshToken(updatedUser.uid);
      await _storage.saveUserData(jsonEncode(userModel.toJson()));

      return AuthResponseDto(
        user: userModel,
        accessToken: idToken,
        refreshToken: updatedUser.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Refresh access token using refresh token
  Future<RefreshTokenResponseDto> refreshToken() async {
    // Firebase automatically handles token refresh. 
    // We get the current user and force a token refresh.
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('No user currently logged in');
    }

    try {
      final idToken = await user.getIdToken(true); // true forces refresh
      
      await _storage.saveAccessToken(idToken);
      
      return RefreshTokenResponseDto(
        accessToken: idToken,
        refreshToken: user.uid,
      );
    } catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }

  /// Get current user from storage or Firebase
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
       return UserModel(
        id: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );
    }
    
    // Fallback to storage if needed, but Firebase is source of truth
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
    return _firebaseAuth.currentUser != null;
  }

  /// Logout - clear all stored data
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _storage.clearAll();
  }
}
