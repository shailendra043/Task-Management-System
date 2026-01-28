// Base exception class
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

// 401 Unauthorized
class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized. Please login again.'])
      : super(message, 401);
}

// 400 Bad Request / Validation Error
class ValidationException extends AppException {
  ValidationException([String message = 'Invalid input data.'])
      : super(message, 400);
}

// 500 Internal Server Error
class ServerException extends AppException {
  ServerException([String message = 'Server error. Please try again later.'])
      : super(message, 500);
}

// Network/Connection Error
class NetworkException extends AppException {
  NetworkException([super.message = 'No internet connection. Please check your network.']);
}

// Generic Error
class GenericException extends AppException {
  GenericException([super.message = 'Something went wrong. Please try again.']);
}
