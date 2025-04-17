import 'package:mzala/core/models/responses/user_response.dart';

class LoginResponse {
  UserResponse? user;
  String? token;

  LoginResponse({this.user, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json['user'] != null ? UserResponse.fromJson(json['user'] as Map<String, dynamic>) : null,
      token: json['token'] as String?,
    );
  }
}
