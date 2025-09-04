import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/authentication/domain/entities/user/user.dart';

import '../entities/login/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(String name, String email, String password);
  Future<void> logout();
  Future<AuthResponse> refreshToken();
  Future<User?> getCurrentUser();
}