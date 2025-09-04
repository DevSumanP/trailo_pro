class ApiConstants {
  // Base URL
  static const String apiBaseUrl = 'https://api.traio.com/v1';

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
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = 'auth/logout';
}
