class RegisterRequest {
  String name;
  String surname;
  String email;
  String password;
  String confirmPassword;
  String contactNumber;
  String address;

  RegisterRequest(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.address,
      required this.contactNumber});

  Map<String, String> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'address': address,
      'contact_number': contactNumber,
    };
  }
}
