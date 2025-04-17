import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'realm_user.g.dart';
part 'realm_user.realm.dart';

@RealmModel()
@JsonSerializable(createToJson: false)
class $RealmUser {
  @PrimaryKey()
  late int? id;
  late String? name;
  late String? surname;
  late String? email;
  late String? contactNumber;
  late String? address;
  late String? picture;
  late String? status;
  late DateTime? emailVerifiedAt;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  RealmUser toRealmObject() => RealmUser(
        id,
        name: name,
        surname: surname,
        email: email,
        contactNumber: contactNumber,
        address: address,
        picture: picture,
        status: status,
        emailVerifiedAt: emailVerifiedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static RealmUser fromJson(Map<String, dynamic> json) => _$$RealmUserFromJson(json).toRealmObject();
}
