class ApiConstants {
  // Base URL
  static const String apiBaseUrl = 'https://dcc.progressnepal.com';

  // Timeouts (in milliseconds)
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 5000;
  static const int sendTimeout = 5000;

  // Default headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Auth endpoints
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String logout = '/api/logout';
  static const String refreshToken = '/api/refresh';
  static const String currentUser = '/users/me';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
