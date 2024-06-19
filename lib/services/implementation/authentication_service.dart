import 'package:her_aid/constants/service_constants.dart';
import 'package:her_aid/models/http_service/http_response.dart';
import 'package:her_aid/models/requests/login_request.dart';
import 'package:her_aid/models/requests/register_request.dart';
import 'package:her_aid/models/responses/login_response.dart';
import 'package:her_aid/models/responses/user_response.dart';
import 'package:her_aid/services/http_service/http_service.dart';
import 'package:her_aid/services/interfaces/i_authentication_service.dart';

class AuthenticationService extends IAuthenticationService {
  final HttpService httpService;

  AuthenticationService(this.httpService);

  @override
  Future<LoginResponse> login(LoginReqest loginCredentials) async {
    try {
      HttpResponse response = await httpService.post(
        data: loginCredentials,
        endpoint: ServiceConstants.authenticationService + ServiceConstants.loginService,
        isProtected: false,
      );

      return LoginResponse(
        user: UserResponse.fromJson(response.data['user'] as Map<String, dynamic>),
        token: response.data['token'] as String?,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerDetails) async {
    try {
      HttpResponse response = await httpService.post(
        data: registerDetails,
        endpoint: ServiceConstants.authenticationService +
            ServiceConstants.registrationService +
            ServiceConstants.userService,
        isProtected: false,
      );

      return LoginResponse(
        user: UserResponse.fromJson(response.data['user'] as Map<String, dynamic>),
        token: response.data['token'] as String?,
      );
    } catch (e) {
      rethrow;
    }
  }
}
