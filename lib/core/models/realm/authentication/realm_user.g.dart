// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

$RealmUser _$$RealmUserFromJson(Map<String, dynamic> json) => $RealmUser()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..surname = json['surname'] as String?
  ..email = json['email'] as String?
  ..contactNumber = json['contactNumber'] as String?
  ..address = json['address'] as String?
  ..picture = json['picture'] as String?
  ..status = json['status'] as String?
  ..emailVerifiedAt = json['emailVerifiedAt'] == null
      ? null
      : DateTime.parse(json['emailVerifiedAt'] as String)
  ..createdAt = json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String)
  ..updatedAt = json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String);
