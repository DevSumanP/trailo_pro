import 'package:dio/dio.dart';
import 'package:trailo_pro/core/constants/storage_keys.dart';

import '../../storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final secureStoreage = SecureStorage();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add auth token to requests
    final String? token =await SecureStorage.getAccessToken();
        
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiry
    if (err.response?.statusCode == 401) {
      // Clear expired token
      await SecureStorage.clearAll();
    }

    handler.next(err);
  }
}
