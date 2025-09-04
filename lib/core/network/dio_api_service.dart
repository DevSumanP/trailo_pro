import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/core/constants/api_constants.dart';

import 'interceptor/auth_interceptor.dart';
import 'interceptor/logging_interceptor.dart';

final Provider<Dio> dioProvider = Provider<Dio>((Ref<Dio> ref) {
  final DioClient dioClient = DioClient();
  return dioClient.dio;
});

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        connectTimeout: Duration(seconds: ApiConstants.connectTimeout),
        receiveTimeout: Duration(seconds: ApiConstants.receiveTimeout),
        sendTimeout: Duration(seconds: ApiConstants.receiveTimeout),
        headers: ApiConstants.defaultHeaders,
      ),
    );

    _dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(),
      LoggingInterceptor(),
    ]);
  }

   Dio get dio => _dio;
}
