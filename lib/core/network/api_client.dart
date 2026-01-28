import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_app/core/constants/api_constants.dart';
import 'package:task_app/core/errors/app_exception.dart';
import 'package:task_app/core/utils/secure_storage_service.dart';

class ApiClient {
  final http.Client _client;
  final SecureStorageService _storage;
  bool _isRefreshing = false;

  ApiClient({
    http.Client? client,
    SecureStorageService? storage,
  })  : _client = client ?? http.Client(),
        _storage = storage ?? SecureStorageService();

  // GET request
  Future<dynamic> get(String endpoint, {bool requiresAuth = true}) async {
    try {
      final headers = await _buildHeaders(requiresAuth);
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      final response = await _client
          .get(uri, headers: headers)
          .timeout(ApiConstants.connectionTimeout);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } on UnauthorizedException {
      // Try to refresh token and retry
      if (requiresAuth && !_isRefreshing) {
        await _refreshTokenAndRetry();
        return await get(endpoint, requiresAuth: requiresAuth);
      }
      rethrow;
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth);
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      final response = await _client
          .post(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConstants.connectionTimeout);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } on UnauthorizedException {
      if (requiresAuth && !_isRefreshing) {
        await _refreshTokenAndRetry();
        return await post(endpoint, body: body, requiresAuth: requiresAuth);
      }
      rethrow;
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth);
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      final response = await _client
          .put(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConstants.connectionTimeout);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } on UnauthorizedException {
      if (requiresAuth && !_isRefreshing) {
        await _refreshTokenAndRetry();
        return await put(endpoint, body: body, requiresAuth: requiresAuth);
      }
      rethrow;
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint, {bool requiresAuth = true}) async {
    try {
      final headers = await _buildHeaders(requiresAuth);
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      final response = await _client
          .delete(uri, headers: headers)
          .timeout(ApiConstants.connectionTimeout);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } on UnauthorizedException {
      if (requiresAuth && !_isRefreshing) {
        await _refreshTokenAndRetry();
        return await delete(endpoint, requiresAuth: requiresAuth);
      }
      rethrow;
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  // Build headers with authentication token
  Future<Map<String, String>> _buildHeaders(bool requiresAuth) async {
    final headers = <String, String>{
      'Content-Type': ApiConstants.contentType,
    };

    if (requiresAuth) {
      final token = await _storage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // Handle HTTP response
  Future<dynamic> _handleResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      case 400:
        throw ValidationException(
          _extractErrorMessage(response.body) ?? 'Invalid request',
        );
      case 401:
        throw UnauthorizedException(
          _extractErrorMessage(response.body) ?? 'Unauthorized',
        );
      case 500:
        throw ServerException(
          _extractErrorMessage(response.body) ?? 'Server error',
        );
      default:
        throw GenericException(
          'Unexpected error: ${response.statusCode}',
        );
    }
  }

  // Extract error message from response body
  String? _extractErrorMessage(String body) {
    try {
      final json = jsonDecode(body);
      return json['message'] ?? json['error'];
    } catch (_) {
      return null;
    }
  }

  // Refresh token and retry
  Future<void> _refreshTokenAndRetry() async {
    _isRefreshing = true;
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        throw UnauthorizedException('No refresh token available');
      }

      // In a real app, this would call the refresh endpoint
      // For now, we'll just throw to trigger re-login
      throw UnauthorizedException('Token refresh not implemented with mock API');
    } finally {
      _isRefreshing = false;
    }
  }
}
