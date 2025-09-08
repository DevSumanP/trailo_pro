// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$AuthDataImpl _$$AuthDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthDataImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresAt: json['expires_at'] as String?,
    );

Map<String, dynamic> _$$AuthDataImplToJson(_$AuthDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_at': instance.expiresAt,
    };
