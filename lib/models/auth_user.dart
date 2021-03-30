import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  final String? userId;
  final String? email;
  final String? photoUrl;
  final String? displayName;

  AuthUser({
    this.userId,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

}
