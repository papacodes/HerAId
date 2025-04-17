import 'package:mzala/core/constants/service_constants.dart';
import 'package:mzala/core/models/http_service/http_response.dart';
import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/core/models/requests/login_request.dart';
import 'package:mzala/core/models/requests/register_request.dart';
import 'package:mzala/core/models/responses/login_response.dart';
import 'package:mzala/core/models/responses/user_response.dart';
import 'package:mzala/services/http_service/http_service.dart';
import 'package:mzala/services/interfaces/i_authentication_service.dart';

class AuthenticationService extends IAuthenticationService {
  final HttpService httpService;

  AuthenticationService(this.httpService);

  @override
  Future<RealmLoginResponse> login(LoginReqest loginCredentials) async {
    try {
      HttpResponse response = await httpService.post(
        data: loginCredentials,
        endpoint: ServiceConstants.authenticationService + ServiceConstants.loginService,
        isProtected: false,
      );

      return $RealmLoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RealmLoginResponse> register(RegisterRequest registerDetails) async {
    try {
      HttpResponse response = await httpService.post(
        data: registerDetails,
        endpoint: ServiceConstants.authenticationService +
            ServiceConstants.registrationService +
            ServiceConstants.userService,
        isProtected: false,
      );

      return $RealmLoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
