import 'package:dio/dio.dart';
import 'package:trailo_pro/core/constants/api_constants.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/auth_response.dart';
import '../../storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final secureStoreage = SecureStorage();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add auth token to requests
    final String? token = await SecureStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] =
          '${ApiConstants.bearer} $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiry
    if (err.response?.statusCode == 401) {
      // Token expired, try to refetch
      try {
        final refreshToken = await SecureStorage.getRefreshToken();
        if (refreshToken != null) {
          final dio = Dio();
          final Response response = await dio.post(
            '${ApiConstants.apiBaseUrl}${ApiConstants.refreshToken}',
            data: {'refresh_token': refreshToken},
          );

          // Save new tokens
          final authResponse = AuthResponse.fromJson(response.data);
          await SecureStorage.saveTokens(
            accessToken: authResponse.data.accessToken,
            refreshToken: authResponse.data.accessToken,
            userId: authResponse.data.user.id.toString(),
          );

          // Retry original request with new token
          err.requestOptions.headers[ApiConstants.authorization] =
              '${ApiConstants.apiBaseUrl}${authResponse.data.accessToken}';

          final cloneReq = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(cloneReq);
        }
      } catch (e) {
        // Refresh failed, clear tokens
        await SecureStorage.clearAll();
      }
      await SecureStorage.clearAll();
    }

    handler.next(err);
  }
}
