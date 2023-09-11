// To parse this JSON data, do
//
//     final voucherDataModel = voucherDataModelFromJson(jsonString);

import 'dart:convert';

VoucherDataModel voucherDataModelFromJson(String str) => VoucherDataModel.fromJson(json.decode(str));

String voucherDataModelToJson(VoucherDataModel data) => json.encode(data.toJson());

class VoucherDataModel {
  String message;
  Coupon coupon;

  VoucherDataModel({
    required this.message,
    required this.coupon,
  });

  factory VoucherDataModel.fromJson(Map<String, dynamic> json) => VoucherDataModel(
    message: json["message"],
    coupon: Coupon.fromJson(json["coupon"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "coupon": coupon.toJson(),
  };
}

class Coupon {
  String discountType;
  String discount;

  Coupon({
    required this.discountType,
    required this.discount,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    discountType: json["discount_type"]??"",
    discount: json["discount"]??"",
  );

  Map<String, dynamic> toJson() => {
    "discount_type": discountType,
    "discount": discount,
  };
}
