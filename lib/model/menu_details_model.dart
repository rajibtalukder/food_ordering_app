// To parse this JSON data, do
//
//     final menuDetailsModel = menuDetailsModelFromJson(jsonString);

import 'dart:convert';

MenuDetailsModel menuDetailsModelFromJson(String str) => MenuDetailsModel.fromJson(json.decode(str));

String menuDetailsModelToJson(MenuDetailsModel data) => json.encode(data.toJson());

class MenuDetailsModel {
  Data data;

  MenuDetailsModel({
    required this.data,
  });

  factory MenuDetailsModel.fromJson(Map<String, dynamic> json) => MenuDetailsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {

  String slug;
  String name;
  String image;
  String price;
  String calorie;
  int processingTime;
  String taxVat;
  String description;
  int status;
  dynamic ingredientId;
  Addons addons;
  Addons variants;

  Data({
    required this.slug,
    required this.name,
    required this.image,
    required this.price,
    required this.calorie,
    required this.processingTime,
    required this.taxVat,
    required this.description,
    required this.status,
    this.ingredientId,
    required this.addons,
    required this.variants,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    slug: json["slug"],
    name: json["name"],
    image: json["image"],
    price: json["price"],
    calorie: json["calorie"] ?? "",
    processingTime: json["processing_time"] ?? 0,
    taxVat: json["tax_vat"],
    description: json["description"],
    status: json["status"],
    ingredientId: json["ingredient_id"],
    addons: Addons.fromJson(json["addons"]),
    variants: Addons.fromJson(json["variants"]),
  );

  Map<String, dynamic> toJson() => {
    "id": slug,
    "name": name,
    "image": image,
    "price": price,
    "calorie": calorie,
    "processing_time": processingTime,
    "tax_vat": taxVat,
    "description": description,
    "status": status,
    "ingredient_id": ingredientId,
    "addons": addons.toJson(),
    "variants": variants.toJson(),
  };
}

class Addons {
  List<Datum> data;

  Addons({
    required this.data,
  });

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String price;

  Datum({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
