// To parse this JSON data, do
//
//     final categoryFoodModel = categoryFoodModelFromJson(jsonString);

import 'dart:convert';

CategoryFoodModel categoryFoodModelFromJson(String str) =>
    CategoryFoodModel.fromJson(json.decode(str));

String categoryFoodModelToJson(CategoryFoodModel data) =>
    json.encode(data.toJson());

class CategoryFoodModel {
  List<CategoryFoodModelDatum> data;
  Links links;
  Meta meta;

  CategoryFoodModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory CategoryFoodModel.fromJson(Map<String, dynamic> json) =>
      CategoryFoodModel(
        data: List<CategoryFoodModelDatum>.from(
            json["data"].map((x) => CategoryFoodModelDatum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class CategoryFoodModelDatum {
  int id;
  String name;
  String slug;
  String image;
  Foods foods;

  CategoryFoodModelDatum({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.foods,
  });

  factory CategoryFoodModelDatum.fromJson(Map<String, dynamic> json) =>
      CategoryFoodModelDatum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        foods: Foods.fromJson(json["foods"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "foods": foods.toJson(),
      };
}

class Foods {
  List<FoodsDatum> data;

  Foods({
    required this.data,
  });

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        data: List<FoodsDatum>.from(
            json["data"].map((x) => FoodsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FoodsDatum {
  String name;
  String slug;
  String image;
  String price;
  String? calorie;
  String description;
  Allergies allergies;

  FoodsDatum({
    required this.name,
    required this.slug,
    required this.image,
    required this.price,
    this.calorie,
    required this.description,
    required this.allergies,
  });

  factory FoodsDatum.fromJson(Map<String, dynamic> json) => FoodsDatum(
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        price: json["price"],
        calorie: json["calorie"],
        description: json["description"],
        allergies: Allergies.fromJson(json["allergies"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "image": image,
        "price": price,
        "calorie": calorie,
        "description": description,
        "allergies": allergies.toJson(),
      };
}

class Allergies {
  List<AllergiesDatum> data;

  Allergies({
    required this.data,
  });

  factory Allergies.fromJson(Map<String, dynamic> json) => Allergies(
        data: List<AllergiesDatum>.from(
            json["data"].map((x) => AllergiesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllergiesDatum {
  int id;
  String name;
  String image;

  AllergiesDatum({
    required this.id,
    required this.name,
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

class Links {
  String first;
  String last;
  dynamic prev;
  String next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
