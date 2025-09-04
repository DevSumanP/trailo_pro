abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException(super.message, [this.statusCode, super.code]);
}

class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message, [super.code]);
}