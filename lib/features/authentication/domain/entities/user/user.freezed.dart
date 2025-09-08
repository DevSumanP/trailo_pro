// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'ward_number')
  int? get wardNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'image')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'header_title')
  String? get headerTitle => throw _privateConstructorUsedError;
  String? get gisLink => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      String? address,
      String? type,
      @JsonKey(name: 'ward_number') int? wardNumber,
      @JsonKey(name: 'image') String? avatarUrl,
      @JsonKey(name: 'header_title') String? headerTitle,
      String? gisLink});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? address = freezed,
    Object? type = freezed,
    Object? wardNumber = freezed,
    Object? avatarUrl = freezed,
    Object? headerTitle = freezed,
    Object? gisLink = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      wardNumber: freezed == wardNumber
          ? _value.wardNumber
          : wardNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      headerTitle: freezed == headerTitle
          ? _value.headerTitle
          : headerTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      gisLink: freezed == gisLink
          ? _value.gisLink
          : gisLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      String? address,
      String? type,
      @JsonKey(name: 'ward_number') int? wardNumber,
      @JsonKey(name: 'image') String? avatarUrl,
      @JsonKey(name: 'header_title') String? headerTitle,
      String? gisLink});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? address = freezed,
    Object? type = freezed,
    Object? wardNumber = freezed,
    Object? avatarUrl = freezed,
    Object? headerTitle = freezed,
    Object? gisLink = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      wardNumber: freezed == wardNumber
          ? _value.wardNumber
          : wardNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      headerTitle: freezed == headerTitle
          ? _value.headerTitle
          : headerTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      gisLink: freezed == gisLink
          ? _value.gisLink
          : gisLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.name,
      required this.email,
      this.address,
      this.type,
      @JsonKey(name: 'ward_number') this.wardNumber,
      @JsonKey(name: 'image') this.avatarUrl,
      @JsonKey(name: 'header_title') this.headerTitle,
      this.gisLink});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? address;
  @override
  final String? type;
  @override
  @JsonKey(name: 'ward_number')
  final int? wardNumber;
  @override
  @JsonKey(name: 'image')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'header_title')
  final String? headerTitle;
  @override
  final String? gisLink;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, address: $address, type: $type, wardNumber: $wardNumber, avatarUrl: $avatarUrl, headerTitle: $headerTitle, gisLink: $gisLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.wardNumber, wardNumber) ||
                other.wardNumber == wardNumber) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.headerTitle, headerTitle) ||
                other.headerTitle == headerTitle) &&
            (identical(other.gisLink, gisLink) || other.gisLink == gisLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, address, type,
      wardNumber, avatarUrl, headerTitle, gisLink);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String name,
      required final String email,
      final String? address,
      final String? type,
      @JsonKey(name: 'ward_number') final int? wardNumber,
      @JsonKey(name: 'image') final String? avatarUrl,
      @JsonKey(name: 'header_title') final String? headerTitle,
      final String? gisLink}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get address;
  @override
  String? get type;
  @override
  @JsonKey(name: 'ward_number')
  int? get wardNumber;
  @override
  @JsonKey(name: 'image')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'header_title')
  String? get headerTitle;
  @override
  String? get gisLink;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
