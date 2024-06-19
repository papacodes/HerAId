import 'package:her_aid/models/requests/login_request.dart';
import 'package:her_aid/models/requests/register_request.dart';
import 'package:her_aid/models/responses/login_response.dart';

abstract class IAuthenticationService {
  Future<LoginResponse> login(LoginReqest loginCredentials);
  Future<LoginResponse> register(RegisterRequest registerDetails);
}
