// To parse this JSON data, do
//
//     final authenticatedUser = authenticatedUserFromJson(jsonString);

import 'dart:convert';

AuthenticatedUser authenticatedUserFromJson(String str) => AuthenticatedUser.fromJson(json.decode(str));

String authenticatedUserToJson(AuthenticatedUser data) => json.encode(data.toJson());

class AuthenticatedUser {
  Data? data;

  AuthenticatedUser({
     this.data,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String firstName;
  dynamic lastName;
  String email;
  String phone;
  String role;
  bool isVerified;
  String verifyField;
  String image;

  Data({
    required this.firstName,
    this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.verifyField,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"] ?? "",
    role: json["role"],
    isVerified: json["is_verified"],
    verifyField: json["verify_field"] ?? "",
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "role": role,
    "is_verified": isVerified,
    "verify_field": verifyField,
    "image": image,
  };
}
