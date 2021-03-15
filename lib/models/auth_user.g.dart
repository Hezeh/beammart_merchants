// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return AuthUser(
    userId: json['userId'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String,
    displayName: json['displayName'] as String,
  );
}

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'displayName': instance.displayName,
    };
