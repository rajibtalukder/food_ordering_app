import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) => OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) => json.encode(data.toJson());

class OrderHistoryModel {
  List<Datum> data;

  OrderHistoryModel({
    required this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String names;
  String invoice;
  int items;
  String image;
  String dateTime;

  Datum({
    required this.names,
    required this.invoice,
    required this.items,
    required this.image,
    required this.dateTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    names: json["names"],
    invoice: json["invoice"],
    items: json["items"],
    image: json["image"],
    dateTime: json["date_time"],
  );

  Map<String, dynamic> toJson() => {
    "names": names,
    "invoice": invoice,
    "items": items,
    "image": image,
    "date_time": dateTime,
  };
}


