import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trailo_pro/features/authentication/domain/entities/login/auth_response.dart';

import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/user/user.dart';


part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/api/login')
  Future<AuthResponse> login(@Body() LoginRequest request);
  
  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> request);
  
  @POST('/api/refresh')
  Future<AuthResponse> refreshToken(@Body() Map<String, dynamic> request);
  
  @GET('/api/me')
  Future<User> getCurrentUser();

  @POST('/api/logout')
  Future<void> logout();
}