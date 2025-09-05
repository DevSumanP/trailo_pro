import 'package:dio/dio.dart';
import 'package:trailo_pro/core/errors/exceptions.dart';
import 'package:trailo_pro/core/storage/local_storage.dart';
import 'package:trailo_pro/features/authentication/data/datasources/auth_api_service.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/auth_response.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/authentication/domain/entities/user/user.dart';
import 'package:trailo_pro/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final authResponse = await _apiService.login(request);

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;
    } on DioException catch (e) {
      throw AuthenticationException(
        _handleDioError(e),
      );
    } catch (e) {
      throw AuthenticationException('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponse> register(
      String name, String email, String password,) async {
    try {
      final authResponse = await _apiService.register(
        {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;
    } on DioException catch (e) {
       throw AuthenticationException(
        _handleDioError(e),
      );
    } catch (e) {
      throw AuthenticationException(
        'Registration failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Continue with local logout even if server request fails
    } finally {
      await SecureStorage.clearAll();
    }
  }

  @override
  Future<AuthResponse> refreshToken() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null) {
      throw const AuthenticationException('No refresh token found');
    }

    try {
      final authResponse = await _apiService.refreshToken(
         {'refresh_token': refreshToken,},
      );

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;

    } on DioException catch (e) {
      await SecureStorage.clearAll();
      throw AuthenticationException(
        _handleDioError(e),
      );
    } catch (e) {
      await SecureStorage.clearAll();
      throw AuthenticationException('Token refresh failed: ${e.toString()}');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = await SecureStorage.getUserId();
    if (userId == null) return null;

    try {
     return await _apiService.getCurrentUser();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await SecureStorage.clearAll();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Unknown error occurred';
        return '$message (Status: $statusCode)';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        return 'Network error occurred. Please try again.';
      default:
        return e.message ?? 'Unknown error occurred';
    }
  }
}
