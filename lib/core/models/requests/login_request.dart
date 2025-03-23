class LoginReqest {
  String email;
  String password;

  LoginReqest({required this.email, required this.password});

  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
