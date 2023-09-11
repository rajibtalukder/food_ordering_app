import 'dart:convert';

List<ReservationTimeModel> reservationTimeModelFromJson(String str) => List<ReservationTimeModel>.from(json.decode(str).map((x) => ReservationTimeModel.fromJson(x)));

String reservationTimeModelToJson(List<ReservationTimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationTimeModel {
  String time;
  bool available;

  ReservationTimeModel({
    required this.time,
    required this.available,
  });

  factory ReservationTimeModel.fromJson(Map<String, dynamic> json) => ReservationTimeModel(
    time: json["time"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "available": available,
  };
}
