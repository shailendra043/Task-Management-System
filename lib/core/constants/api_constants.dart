class ApiConstants {
  // Base URL - can be easily changed to point to real API
  static const String baseUrl = 'https://api.example.com';
  
  // Auth Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  
  // Task Endpoints
  static const String tasksEndpoint = '/tasks';
  static String taskByIdEndpoint(String id) => '/tasks/$id';
  
  // Headers
  static const String contentType = 'application/json';
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
