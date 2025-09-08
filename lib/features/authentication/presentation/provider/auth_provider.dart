// lib/features/authentication/presentation/provider/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/features/authentication/data/datasources/auth_api_service.dart';
import 'package:trailo_pro/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:trailo_pro/features/authentication/domain/entities/auth_state/auth_state.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/network/dio_api_service.dart';

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiService(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(authApiServiceProvider);
  return AuthRepositoryImpl(apiService);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    _checkAuthStatus();
  }
  
  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();
    
    try {
      final user = await _repository.getCurrentUser();
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }
  
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _repository.login(request);
      state = AuthState.authenticated(response.data.user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> register(String name, String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final response = await _repository.register(name, email, password);
      state = AuthState.authenticated(response.data.user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      await _repository.logout();
      state = const AuthState.unauthenticated();
    } catch (e) {
      // Even if logout fails on server, clear local state
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> refreshToken() async {
    try {
      final response = await _repository.refreshToken();
      state = AuthState.authenticated(response.data.user);
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

}