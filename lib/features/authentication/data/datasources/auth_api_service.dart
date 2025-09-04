// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// import '../../domain/entities/login/login_request_model.dart';


// @RestApi
// abstract class AuthApiService {
//   factory AuthApiService(Dio dio) = _AuthApiService;

//   @POST('/auth/login')
//   Future<ApiResponse<UserModel>> login(@Body() LoginRequest request);
  
//   @POST('/auth/register')
//   Future<ApiResponse<UserModel>> register(@Body() RegisterRequest request);
  
//   @POST('/auth/refresh')
//   Future<ApiResponse<TokenResponse>> refreshToken(@Body() RefreshTokenRequest request);
  
//   @GET('/auth/me')
//   Future<ApiResponse<UserModel>> getCurrentUser();
// }