// To parse this JSON data, do
//
//     final reservationUserData = reservationUserDataFromJson(jsonString);

import 'dart:convert';

ReservationUserData reservationUserDataFromJson(String str) => ReservationUserData.fromJson(json.decode(str));

String reservationUserDataToJson(ReservationUserData data) => json.encode(data.toJson());

class ReservationUserData {
  List<Datum> data;

  ReservationUserData({
    required this.data,
  });

  factory ReservationUserData.fromJson(Map<String, dynamic> json) => ReservationUserData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int totalPerson;
  String expectedDate;
  String expectedTime;
  String phone;
  String invoice;
  dynamic name;
  dynamic email;
  String status;
  dynamic occasion;
  dynamic specialRequest;

  Datum({
    required this.totalPerson,
    required this.expectedDate,
    required this.expectedTime,
    required this.phone,
    required this.invoice,
    this.name,
    this.email,
    required this.status,
    this.occasion,
    this.specialRequest,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    totalPerson: json["total_person"],
    expectedDate: json["expected_date"],
    expectedTime: json["expected_time"],
    phone: json["phone"],
    invoice: json["invoice"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    occasion: json["occasion"],
    specialRequest: json["special_request"],
  );

  Map<String, dynamic> toJson() => {
    "total_person": totalPerson,
    "expected_date": expectedDate,
    "expected_time": expectedTime,
    "phone": phone,
    "invoice": invoice,
    "name": name,
    "email": email,
    "status": status,
    "occasion": occasion,
    "special_request": specialRequest,
  };
}
