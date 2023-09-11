import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:klio/model/user_address_model.dart';
import '../constants/colors.dart';
import '../model/cart_items_model.dart';
import '../model/popular_items_model.dart';
import '../model/voucher_data_model.dart';
import '../service/api_client.dart';
import '../utils/shared_preferences.dart';
import '../utils/utils.dart';
import '../view/cart/widgets/payment.dart';
import '../view/cart/widgets/success_order.dart';
import '../view/global_widgets/custom_dialog.dart';

enum SingingCharacter { cash, online }

class CartController with ChangeNotifier {
  List<CartItemsModel> localCartItems = [];
  List<UserAddress>? userAddress;
  int isChange = 0;
  CartItemsModel? cartItem;
  bool isLoading = true;
  bool isVoucherChangeVoucher = true;
  PopularItemsModel? cartItemList;

  double cartSubTotal = 0;
  double cartVat = 0;
  int selectAddress = 0;
  UserAddress? singleAddress;
  VoucherDataModel? voucherData;
  double discount = 0.00;
  bool useReward = false;

  changeReward(bool value) {
    useReward = value;
    notifyListeners();
  }

  changeSelectedAddress(int value) {
    selectAddress = value;
    notifyListeners();
  }

  increaseQuantity({required bool isAddons, int? index}) {
    if (cartItem == null) return;
    if (isAddons) {
      cartItem!.data.addons.data[index!].quantity++;
    } else {
      cartItem!.data.quantity++;
    }
    notifyListeners();
  }

  decreaseQuantity({required bool isAddons, int? index}) {
    if (cartItem == null) return;
    if (isAddons) {
      cartItem!.data.addons.data[index!].quantity--;
    } else {
      if (cartItem!.data.quantity == 1) return;
      cartItem!.data.quantity--;
    }
    notifyListeners();
  }

  increaseCartQuantity(CartItemsModel localData) {
    localData.data.quantity++;
    calculateSubTotal();
    saveCartData();
  }

  decreaseCartQuantity(CartItemsModel localData) {
    if (localData.data.quantity == 1) return;
    localData.data.quantity--;
    calculateSubTotal();
    saveCartData();
  }

  selectVariants(String variant, int id) {
    cartItem!.data.selectedVariants = variant;
    cartItem!.data.selectedVariantsId = id;
    notifyListeners();
  }

  /*bool isCart(String slug) {
    CartItemsModel? temp;
    for (var element in localCartItems) {
      if (element.data.slug == slug) {
        temp = element;
      }
    }
    if (temp == null) return false;
    var cartData = temp;
    return cartData.data.slug == slug;
  }*/

  addCartItems() async {
    localCartItems.add(cartItem!);
    isChange = localCartItems.length;
    List<String> temp = [];
    for (var element in localCartItems) {
      temp.add(cartItemsModelToJson(element));
    }
    SharedPref().saveList('carts', temp);
    notifyListeners();
  }

  removeCartItems(String slug) async {
    localCartItems.removeWhere((element) {
      return element.data.slug == slug;
    });
    cartItemList!.data.removeWhere((element) {
      return element.slug == slug;
    });

    // for changing icon ui, because selector will rebuild only if isChange change
    isChange = localCartItems.length;

    List<String> temp = [];

    for (var element in localCartItems) {
      temp.add(cartItemsModelToJson(element));
    }

    SharedPref().saveList("carts", temp);

    calculateSubTotal();
  }

  saveCartData() async {
    List<String> temp = [];
    for (var element in localCartItems) {
      temp.add(cartItemsModelToJson(element));
    }
    SharedPref().saveList("carts", temp);
  }

  Future<void> getCartItems() async {
    List<String> temp = await SharedPref().getList("carts") ?? [];
    localCartItems.clear();
    for (var element in temp) {
      localCartItems.add(cartItemsModelFromJson(element));
    }
    notifyListeners();
  }

  Future<void> getCartItemsById(BuildContext context) async {
    List<String> temp = [];

    for (CartItemsModel element in localCartItems) {
      temp.add(element.data.slug);
    }

    var queryParameters = {
      "slugs": temp,
    };

    String queryString = queryParameters.entries
        .map((e) => '${e.key}[]=${e.value.join('&${e.key}[]=')}')
        .join('&');

    var response = await ApiClient()
        .get(
      'cart?$queryString',
      header: Utils().apiHeader,
    )
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });

    if (response == null) return;

    cartItemList = popularItemsModelFromJson(response);
    isLoading = false;

    calculateSubTotal();
    return;
  }

  calculateSubTotal() {
    if (cartItemList == null) return;
    cartSubTotal = 0;
    cartVat = 0;

    for (CartItemsModel localElement in localCartItems) {
      for (var element in cartItemList!.data) {
        if (element.slug == localElement.data.slug) {
          double singleItemTotalPrice = 0;

          for (var variants in element.variants.data) {
            if (variants.id == localElement.data.selectedVariantsId) {
              singleItemTotalPrice +=
                  double.parse(variants.price) * localElement.data.quantity;
              cartSubTotal += singleItemTotalPrice;
              break;
            }
          }

          for (var addons in localElement.data.addons.data) {
            if (addons.quantity > 0) {
              int temp =
                  element.addons.data.indexWhere((e) => e.id == addons.id);
              if (temp != -1) {
                cartSubTotal += double.parse(element.addons.data[temp].price) *
                    addons.quantity;

                singleItemTotalPrice +=
                    double.parse(element.addons.data[temp].price) *
                        addons.quantity;
              }
            }
          }

          cartVat += (double.parse(element.taxVat) / 100) * singleItemTotalPrice;

          break;
        }
      }
    }

    notifyListeners();
  }

  Future<bool> getVoucher(BuildContext context, couponCode) async {
    var body = {"coupon_code": couponCode};
    var response = await ApiClient()
        .post('voucher', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      isVoucherChangeVoucher = !isVoucherChangeVoucher;
      notifyListeners();
      Utils.showSnackBar(e.message, color: red, context);
    });
    if (response == null) return false;
    voucherData = voucherDataModelFromJson(response);

    isVoucherChangeVoucher = !isVoucherChangeVoucher;
    notifyListeners();
    return true;
  }

  calculateDiscount() {
    if (voucherData != null) {
      if (voucherData!.coupon.discountType == "percentage") {
        discount =
            ((double.parse(voucherData!.coupon.discount) / 100) * cartSubTotal);
      } else {
        discount = cartSubTotal - double.parse(voucherData!.coupon.discount);
      }
    }
  }

  void deleteVoucher() {
    voucherData = null;
    discount = 0.00;
    isVoucherChangeVoucher = !isVoucherChangeVoucher;
    notifyListeners();
  }

  ///user address api

  Future<bool> getUserAddress(BuildContext context) async {
    userAddress?.clear();
    var response = await ApiClient()
        .get('address', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return false;
    userAddress = userAddressFromJson(response);
    print(response);
    isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> updateUserAddress(
      BuildContext context, String type, String location, bool isUpdate,
      {String? id}) async {
    isLoading= true;
    var body = {
      "type": type,
      "location": location,
    };
    print(body);
    var response = isUpdate
        ? await ApiClient()
            .put('address/$id', jsonEncode(body), header: Utils().apiHeader)
            .catchError((e) {
            Utils.showSnackBar(e.message, context);
            print(e);
          })
        : await ApiClient()
            .post('address', payloadObj: body, header: Utils().apiHeader)
            .catchError((e) {
            Utils.showSnackBar(e.message, context);
          });
    isLoading = false;
    if (response == null) return false;
    getUserAddress(context);
    print(response);
    Utils.showSnackBar(json.decode(response)['message'], context);
    notifyListeners();
    return true;
  }

  /// add order

  Future<void> addOrder(
      BuildContext context, String deliveryMethod, String paymentMethod) async {
    try {
      var body = {
        "discount": double.parse(discount.toStringAsFixed(2)),
        //if (deliveryMethod != "pickup") "address_book": selectAddress,
        "address_book": deliveryMethod == "pickup" ? 0 : selectAddress,
        "shipping_method": deliveryMethod,
        "payment_method": paymentMethod,
        "items": [
          for (int i = 0; i < localCartItems.length; i++)
            localCartItems[i].data.toJsonForOrder()
        ]
      };

      Utils().showLoadingIndicator(context);
      var response = await ApiClient()
          .post('checkout', payloadObj: body, header: Utils().apiHeader)
          .catchError((e) {
        Utils.showSnackBar(e.message, context);
      });
      Utils.hideLoading(context);

      if (response == null) return;

      var decodedRes = json.decode(response);

      if (deliveryMethod != "Cash" && decodedRes["redirect"] != null) {
        PaymentSheet(context, decodedRes["redirect"]);
      } else if (decodedRes["message"] != null) {
        showCustomDialog(
          context,
          widget: successOrder(decodedRes["message"], context),
          heightReduce: MediaQuery.of(context).size.height * 0.55,
          widthReduce: MediaQuery.of(context).size.width * 0.3,
          canPop: false,
        );
      }
    } catch (e) {
      print(e);
      Utils.showSnackBar("Something went wrong", context, color: red);
    }
  }

  /// payment method ui

  SingingCharacter? paymentMethod = SingingCharacter.cash;
  bool showOnlinePaymentOption = false;
  int selectedPaymentWay = 2;

  changePaymentMethod(SingingCharacter value) {
    paymentMethod = value;
    if (paymentMethod == SingingCharacter.cash) {
      showOnlinePaymentOption = false;
    } else {
      showOnlinePaymentOption = true;
    }
    notifyListeners();
  }

  changePaymentWay(int vale) {
    selectedPaymentWay = vale;
    notifyListeners();
  }

}
