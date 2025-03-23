import 'package:her_aid/core/models/responses/user_response.dart';

class LoginResponse {
  UserResponse? user;
  String? token;

  LoginResponse({this.user, this.token});
}
