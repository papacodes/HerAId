// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

$RealmLoginResponse _$$RealmLoginResponseFromJson(Map<String, dynamic> json) =>
    $RealmLoginResponse()
      ..token = json['token'] as String?
      ..user = json['user'] == null
          ? null
          : $RealmUser.fromJson(json['user'] as Map<String, dynamic>);
