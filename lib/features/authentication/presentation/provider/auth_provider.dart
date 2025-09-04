
import 'package:dio/dio.dart';
import 'package:trailo_pro/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:trailo_pro/features/authentication/domain/entities/auth_state/auth_state.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/login_request.dart';
import 'package:trailo_pro/features/authentication/domain/entities/user/user.dart';
import 'package:trailo_pro/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_api_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(dio);
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
      state = AuthState.authenticated(response.user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> register(String name, String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final response = await _repository.register(name, email, password);
      state = AuthState.authenticated(response.user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }
}