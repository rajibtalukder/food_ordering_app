import 'dart:convert';

CartItemsModel cartItemsModelFromJson(String str) =>
    CartItemsModel.fromJson(json.decode(str));

String cartItemsModelToJson(CartItemsModel data) => json.encode(data.toJson());

class CartItemsModel {
  Data data;

  CartItemsModel({
    required this.data,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String slug;
  int quantity;
  int selectedVariantsId;
  String selectedVariants;
  Addons addons;

  Data({
    required this.slug,
    required this.quantity,
    required this.selectedVariants,
    required this.addons,
    required this.selectedVariantsId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slug: json["slug"],
        quantity: json["quantity"],
        selectedVariants: json["selectedVariants"],
        selectedVariantsId: json["selectedVariantsId"],
        addons: Addons.fromJson(json["addons"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "quantity": quantity,
        "selectedVariants": selectedVariants,
        "selectedVariantsId": selectedVariantsId,
        "addons": addons.toJson(),
      };

  Map<String, dynamic> toJsonForOrder() => {
        "slug": slug,
        "quantity": quantity,
        "variant_id": selectedVariantsId,
        "addons": addons.toJsonForOrder(),
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

  // I changed the to json file according to the checkout order format
  List toJsonForOrder() => List<dynamic>.from(data.map((x) => x.toJson()));
}

class Datum {
  int id;
  int quantity;

  Datum({
    required this.id,
    required this.quantity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}
