// To parse this JSON data, do
//
//     final orderHistoryDetailsModel = orderHistoryDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryDetailsModel orderHistoryDetailsModelFromJson(String str) => OrderHistoryDetailsModel.fromJson(json.decode(str));

String orderHistoryDetailsModelToJson(OrderHistoryDetailsModel data) => json.encode(data.toJson());

class OrderHistoryDetailsModel {
  Data data;

  OrderHistoryDetailsModel({
    required this.data,
  });

  factory OrderHistoryDetailsModel.fromJson(Map<String, dynamic> json) => OrderHistoryDetailsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String invoice;
  String status;
  String processingTime;
  String availableTime;
  String discount;
  String rewardsAmount;
  String serviceCharge;
  String deliveryCharge;
  String grandTotal;
  String deliveryType;
  Address address;
  dynamic note;
  int rewards;
  String dateTime;
  OrderDetails orderDetails;

  Data({
    required this.invoice,
    required this.status,
    required this.processingTime,
    required this.availableTime,
    required this.discount,
    required this.rewardsAmount,
    required this.serviceCharge,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.deliveryType,
    required this.address,
    this.note,
    required this.rewards,
    required this.dateTime,
    required this.orderDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoice: json["invoice"],
    status: json["status"],
    processingTime: json["processing_time"],
    availableTime: json["available_time"],
    discount: json["discount"],
    rewardsAmount: json["rewards_amount"],
    serviceCharge: json["service_charge"],
    deliveryCharge: json["delivery_charge"],
    grandTotal: json["grand_total"],
    deliveryType: json["delivery_type"],
    address: Address.fromJson(json["address"]),
    note: json["note"],
    rewards: json["rewards"],
    dateTime: json["date_time"],
    orderDetails: OrderDetails.fromJson(json["orderDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "invoice": invoice,
    "status": status,
    "processing_time": processingTime,
    "available_time": availableTime,
    "discount": discount,
    "rewards_amount": rewardsAmount,
    "service_charge": serviceCharge,
    "delivery_charge": deliveryCharge,
    "grand_total": grandTotal,
    "delivery_type": deliveryType,
    "address": address.toJson(),
    "note": note,
    "rewards": rewards,
    "date_time": dateTime,
    "orderDetails": orderDetails.toJson(),
  };
}

class Address {
  String type;
  String location;

  Address({
    required this.type,
    required this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    type: json["type"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "location": location,
  };
}

class OrderDetails {
  List<OrderDetailsDatum> data;

  OrderDetails({
    required this.data,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    data: List<OrderDetailsDatum>.from(json["data"].map((x) => OrderDetailsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDetailsDatum {
  String menu;
  String variant;
  String processingTime;
  String status;
  String price;
  int quantity;
  String vat;
  String totalPrice;
  Addons addons;

  OrderDetailsDatum({
    required this.menu,
    required this.variant,
    required this.processingTime,
    required this.status,
    required this.price,
    required this.quantity,
    required this.vat,
    required this.totalPrice,
    required this.addons,
  });

  factory OrderDetailsDatum.fromJson(Map<String, dynamic> json) => OrderDetailsDatum(
    menu: json["menu"],
    variant: json["variant"],
    processingTime: json["processing_time"],
    status: json["status"],
    price: json["price"],
    quantity: json["quantity"],
    vat: json["vat"],
    totalPrice: json["total_price"],
    addons: Addons.fromJson(json["addons"]),
  );

  Map<String, dynamic> toJson() => {
    "menu": menu,
    "variant": variant,
    "processing_time": processingTime,
    "status": status,
    "price": price,
    "quantity": quantity,
    "vat": vat,
    "total_price": totalPrice,
    "addons": addons.toJson(),
  };
}

class Addons {
  List<AddonsDatum> data;

  Addons({
    required this.data,
  });

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
    data: List<AddonsDatum>.from(json["data"].map((x) => AddonsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AddonsDatum {
  String name;
  String price;
  int quantity;

  AddonsDatum({
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory AddonsDatum.fromJson(Map<String, dynamic> json) => AddonsDatum(
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "quantity": quantity,
  };
}
