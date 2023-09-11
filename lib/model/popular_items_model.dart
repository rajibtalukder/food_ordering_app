// To parse this JSON data, do
//
//     final popularItemsModel = popularItemsModelFromJson(jsonString);

import 'dart:convert';

PopularItemsModel popularItemsModelFromJson(String str) => PopularItemsModel.fromJson(json.decode(str));

String popularItemsModelToJson(PopularItemsModel data) => json.encode(data.toJson());

class PopularItemsModel {
  List<PopularItemsModelDatum> data;

  PopularItemsModel({
    required this.data,
  });

  factory PopularItemsModel.fromJson(Map<String, dynamic> json) => PopularItemsModel(
    data: List<PopularItemsModelDatum>.from(json["data"].map((x) => PopularItemsModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PopularItemsModelDatum {
  String name;
  String slug;
  String image;
  String price;
  String taxVat;
  String? calorie;
  String description;
  Allergies allergies;
  Addons addons;
  Addons variants;

  PopularItemsModelDatum({
    required this.name,
    required this.slug,
    required this.image,
    required this.price,
    required this.taxVat,
    this.calorie,
    required this.description,
    required this.allergies,
    required this.addons,
    required this.variants,
  });

  factory PopularItemsModelDatum.fromJson(Map<String, dynamic> json) => PopularItemsModelDatum(
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    price: json["price"],
    taxVat: json["tax_vat"],
    calorie: json["calorie"],
    description: json["description"],
    allergies: Allergies.fromJson(json["allergies"]),
    addons: Addons.fromJson(json["addons"]),
    variants: Addons.fromJson(json["variants"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "image": image,
    "price": price,
    "calorie": calorie,
    "description": description,
    "allergies": allergies.toJson(),
    "addons": addons.toJson(),
    "variants": variants.toJson(),
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
  int id;
  String name;
  String price;

  AddonsDatum({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddonsDatum.fromJson(Map<String, dynamic> json) => AddonsDatum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}

class Allergies {
  List<AllergiesDatum> data;

  Allergies({
    required this.data,
  });

  factory Allergies.fromJson(Map<String, dynamic> json) => Allergies(
    data: List<AllergiesDatum>.from(json["data"].map((x) => AllergiesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllergiesDatum {
  int id;
  dynamic name;
  String image;

  AllergiesDatum({
    required this.id,
    this.name,
    required this.image,
  });

  factory AllergiesDatum.fromJson(Map<String, dynamic> json) => AllergiesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
