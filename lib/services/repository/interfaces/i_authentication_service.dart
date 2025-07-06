import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/core/models/requests/login_request.dart';
import 'package:mzala/core/models/requests/register_request.dart';
// import 'package:mzala/core/models/responses/login_response.dart';

abstract class IAuthenticationService {
  Future<$RealmLoginResponse> login(LoginReqest loginCredentials);
  Future<$RealmLoginResponse> register(RegisterRequest registerDetails);
}
