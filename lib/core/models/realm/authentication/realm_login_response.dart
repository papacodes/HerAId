import 'package:mzala/core/models/realm/authentication/realm_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'realm_login_response.g.dart';
part 'realm_login_response.realm.dart';

@RealmModel()
@JsonSerializable(createToJson: false)
class $RealmLoginResponse {
  late String? token;
  late $RealmUser? user;

  RealmLoginResponse toRealmObject() => RealmLoginResponse(
        token: token,
        user: user?.toRealmObject(),
      );

  static RealmLoginResponse fromJson(Map<String, dynamic> json) => _$$RealmLoginResponseFromJson(json).toRealmObject();
}
