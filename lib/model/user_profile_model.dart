// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  Data data;

  UserProfileModel({
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String role;
  bool isVerified;
  dynamic verifyField;
  String image;
  int reward;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    this.verifyField,
    required this.image,
    required this.reward,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        role: json["role"] ?? "",
        isVerified: json["is_verified"] ?? "",
        verifyField: json["verify_field"] ?? "",
        image: json["image"] ?? "",
        reward: json["rewards_available"] ?? "",
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
        "rewards_available": reward,
      };
}
