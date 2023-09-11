// To parse this JSON data, do
//
//     final userAddress = userAddressFromJson(jsonString);

import 'dart:convert';

List<UserAddress> userAddressFromJson(String str) => List<UserAddress>.from(json.decode(str).map((x) => UserAddress.fromJson(x)));

String userAddressToJson(List<UserAddress> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAddress {
  String type;
  String location;

  UserAddress({
    required this.type,
    required this.location,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    type: json["type"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "location": location,
  };
}
