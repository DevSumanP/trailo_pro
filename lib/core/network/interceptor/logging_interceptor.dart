import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../logger/custom_logger.dart';

class LoggingInterceptor extends Interceptor {



  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      CustomLogger.i('REQUEST[$options.method}] => PATH: ${options.path}');
      CustomLogger.i('Query Parameters: ${options.queryParameters}');
      CustomLogger.i('Headers: ${options.headers}');
      if (options.data != null) {
        CustomLogger.i('Data: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
     CustomLogger.d(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      CustomLogger.d('Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      CustomLogger.e(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      CustomLogger.e('Error: ${err.message}');
      if (err.response?.data != null) {
        CustomLogger.e('Error Data: ${err.response?.data}');
      }
    }
    handler.next(err);
  }
}
