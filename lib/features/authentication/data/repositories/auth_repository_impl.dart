import 'package:dio/dio.dart';
import 'package:trailo_pro/core/constants/api_constants.dart';
import 'package:trailo_pro/core/errors/exceptions.dart';
import 'package:trailo_pro/core/storage/local_storage.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/auth_response.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/authentication/domain/entities/user/user.dart';
import 'package:trailo_pro/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);
  
  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response =
          await _dio.post(ApiConstants.login, data: request.toJson());

      final AuthResponse authResponse = AuthResponse.fromJson(response.data);

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;
    } on DioException catch (e) {
      throw AuthenticationException(
        e.response?.data['message'] ?? 'Login failed',
      );
    }
  }

  @override
  Future<AuthResponse> register(
      String name, String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;
    } on DioException catch (e) {
      throw AuthenticationException(
        e.response?.data['message'] ?? 'Registration failed',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
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
      final response = await _dio.post(
        ApiConstants.apiBaseUrl,
        data: {'refresh_token': refreshToken},
      );

      final authResponse = AuthResponse.fromJson(response.data);

      await SecureStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        userId: authResponse.user.id,
      );

      return authResponse;
    } on DioException catch (e) {
      await SecureStorage.clearAll();
      throw AuthenticationException(
        e.response?.data['message'] ?? 'Token refresh failed',
      );
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = await SecureStorage.getUserId();
    if (userId == null) return null;

    try {
      final response = await _dio.get('/users/me');
      return User.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
