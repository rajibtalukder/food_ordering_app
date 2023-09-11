import 'dart:convert';

import 'package:intl/intl.dart';

ReservationModel reservationModelFromJson(String str) => ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationModel {
  Data data;

  ReservationModel({
    required this.data,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String totalPerson;
  DateTime expectedDate;
  String expectedTime;
  String phone;
  String invoice;

  Data({
    required this.totalPerson,
    required this.expectedDate,
    required this.expectedTime,
    required this.phone,
    required this.invoice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPerson: json["total_person"],
    expectedDate: DateFormat('MM-dd-yyyy').parse(json["expected_date"]),
    expectedTime: json["expected_time"],
    phone: json["phone"],
    invoice: json["invoice"],
  );

  Map<String, dynamic> toJson() => {
    "total_person": totalPerson,
    "expected_date": "${expectedDate.year.toString().padLeft(4, '0')}-${expectedDate.month.toString().padLeft(2, '0')}-${expectedDate.day.toString().padLeft(2, '0')}",
    "expected_time": expectedTime,
    "phone": phone,
    "invoice": invoice,
  };
}