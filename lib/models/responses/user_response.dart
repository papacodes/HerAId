class UserResponse {
  int id;
  String name;
  String surname;
  String email;
  String contactNumber;
  String? emergencyContact;
  String? university;
  String? picture;
  String status;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  UserResponse({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.contactNumber,
    this.emergencyContact,
    this.university,
    this.picture,
    required this.status,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String,
      emergencyContact: json['emergency_contact'] as String?,
      university: json['university'] as String?,
      picture: json['picture'] as String?,
      status: json['status'] as String,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
