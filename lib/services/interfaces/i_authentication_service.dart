import 'package:her_aid/core/models/requests/login_request.dart';
import 'package:her_aid/core/models/requests/register_request.dart';
import 'package:her_aid/core/models/responses/login_response.dart';

abstract class IAuthenticationService {
  Future<LoginResponse> login(LoginReqest loginCredentials);
  Future<LoginResponse> register(RegisterRequest registerDetails);
}
