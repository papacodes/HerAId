import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:realm/realm.dart';
import 'package:mzala/core/models/realm/authentication/realm_user.dart';

class RealmService {
  static final RealmService _instance = RealmService._internal();
  late final Realm _realm;

  factory RealmService() {
    return _instance;
  }

  RealmService._internal() {
    final config = Configuration.local(
      [RealmUser.schema, RealmLoginResponse.schema],
      schemaVersion: 1,
    );
    _realm = Realm(config);
  }

  Future<void> saveUserData($RealmLoginResponse loginResponse) async {
    if (loginResponse.user == null) return;

    final user = loginResponse.user!;

    await _realm.writeAsync(() {
      _realm.add(
        RealmLoginResponse(
          token: loginResponse.token,
          user: RealmUser(
            user.id,
            name: user.name,
            surname: user.surname,
            email: user.email,
            contactNumber: user.contactNumber,
            address: user.address,
            picture: user.picture,
            status: user.status,
            emailVerifiedAt: user.emailVerifiedAt,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
          ),
        ),
        update: true,
      );
    });
  }

  RealmLoginResponse? getCurrentUserData() {
    return _realm.all<RealmLoginResponse>().firstOrNull;
  }

  String? getAuthToken() {
    return getCurrentUserData()?.token;
  }

  Future<void> logout() async {
    await _realm.writeAsync(() {
      _realm.deleteAll();
    });
  }
}
