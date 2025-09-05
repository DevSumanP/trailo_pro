import 'package:logger/logger.dart';

class CustomLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, 
      errorMethodCount: 5, 
      colors: true,
      printEmojis: true,
    ),
  );

  // Info log
  static void i(dynamic message) {
    _logger.i(message);
  }

  // Debug log
  static void d(dynamic message) {
    _logger.d(message);
  }

  // Warning log
  static void w(dynamic message) {
    _logger.w(message);
  }

  // Error log
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
