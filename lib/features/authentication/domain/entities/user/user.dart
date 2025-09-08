import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    String? address,
    String? type,
    @JsonKey(name: 'ward_number') int? wardNumber,
    @JsonKey(name: 'image') String? avatarUrl,
    @JsonKey(name: 'header_title') String? headerTitle,
    String? gisLink,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
