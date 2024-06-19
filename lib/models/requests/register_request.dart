class RegisterRequest {
  String name;
  String surname;
  String email;
  String password;
  String contactNumber;

  RegisterRequest(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.contactNumber});

  Map<String, String> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'contact_number': contactNumber,
    };
  }
}
