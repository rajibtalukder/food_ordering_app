import 'dart:convert';

GeneralSettingModel generalSettingModelFromJson(String str) => GeneralSettingModel.fromJson(json.decode(str));

String generalSettingModelToJson(GeneralSettingModel data) => json.encode(data.toJson());

class GeneralSettingModel {
  String appName;
  String email;
  String phone;
  dynamic whiteLogo;
  dynamic darkLogo;
  dynamic favicon;
  dynamic invoiceLogo;
  String serviceCharge;
  String deliveryCharge;
  String rewardExchangeRate;
  String currencySymbol;
  String currencyCode;
  String currencyPosition;

  GeneralSettingModel({
    required this.appName,
    required this.email,
    required this.phone,
    this.whiteLogo,
    this.darkLogo,
    this.favicon,
    this.invoiceLogo,
    required this.serviceCharge,
    required this.deliveryCharge,
    required this.rewardExchangeRate,
    required this.currencySymbol,
    required this.currencyCode,
    required this.currencyPosition,
  });

  factory GeneralSettingModel.fromJson(Map<String, dynamic> json) => GeneralSettingModel(
    appName: json["app_name"],
    email: json["email"],
    phone: json["phone"],
    whiteLogo: json["white_logo"],
    darkLogo: json["dark_logo"],
    favicon: json["favicon"],
    invoiceLogo: json["invoice_logo"],
    serviceCharge: json["service_charge"],
    deliveryCharge: json["delivery_charge"],
    rewardExchangeRate: json["reward_exchange_rate"],
    currencySymbol: json["currency_symbol"],
    currencyCode: json["currency_code"],
    currencyPosition: json["currency_position"],
  );

  Map<String, dynamic> toJson() => {
    "app_name": appName,
    "email": email,
    "phone": phone,
    "white_logo": whiteLogo,
    "dark_logo": darkLogo,
    "favicon": favicon,
    "invoice_logo": invoiceLogo,
    "service_charge": serviceCharge,
    "delivery_charge": deliveryCharge,
    "reward_exchange_rate": rewardExchangeRate,
    "currency_symbol": currencySymbol,
    "currency_code": currencyCode,
    "currency_position": currencyPosition,
  };
}
