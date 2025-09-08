// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String?,
      type: json['type'] as String?,
      wardNumber: (json['ward_number'] as num?)?.toInt(),
      avatarUrl: json['image'] as String?,
      headerTitle: json['header_title'] as String?,
      gisLink: json['gisLink'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'type': instance.type,
      'ward_number': instance.wardNumber,
      'image': instance.avatarUrl,
      'header_title': instance.headerTitle,
      'gisLink': instance.gisLink,
    };
