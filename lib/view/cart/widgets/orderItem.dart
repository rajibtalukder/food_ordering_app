import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/model/popular_items_model.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../../model/cart_items_model.dart';
import '../../../view_model/home_controller.dart';
import '../../global_widgets/custom_button.dart';
import '../../global_widgets/texts.dart';
import '../../home/bottom_sheet.dart';

Widget orderItem(int index, CartController cartPro, BuildContext context) {
  PopularItemsModelDatum data = cartPro.cartItemList!.data[index];
  CartItemsModel? localData = cartPro.localCartItems
      .firstWhere((element) => element.data.slug == data.slug);
  var homePro = Provider.of<HomeController>(context, listen: false);
  return Column(
    children: [
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        homePro.getMenuDetails(context, data.slug);
                        await bottomSheet(context, data.slug, item: localData);
                        cartPro.saveCartData();
                        cartPro.calculateSubTotal();
                      },
                      child: SizedBox(
                        height: 80.w,
                        width: 80.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(data.image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            data.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontMedium,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Selector<CartController, Object>(
                          selector: (context, provider) =>
                              localData.data.quantity,
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cartPro.decreaseCartQuantity(localData);
                                  },
                                  child: circleAvatar(
                                    Icons.remove,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Text(
                                  localData.data.quantity.toString(),
                                  style: TextStyle(fontSize: fontMedium),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartPro.increaseCartQuantity(localData);
                                  },
                                  child: circleAvatar(
                                    Icons.add,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartPro.removeCartItems(data.slug);
                                  },
                                  child: SizedBox(
                                      height: 25.h,
                                      width: 25.w,
                                      child: Image.asset('assets/delete.png')),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<CartController, Object>(
                          selector: (context, provider) =>
                              provider.cartSubTotal,
                          builder: (context, value, child) {
                            AddonsDatum temp = data.variants.data.firstWhere(
                                (element) =>
                                    element.id ==
                                    localData.data.selectedVariantsId);
                            return titleText(
                                '${homePro.generalSetting == null ? "£" : homePro.generalSetting!.currencySymbol}${(double.parse(temp.price) * localData.data.quantity).toStringAsFixed(2)}',
                                size: fontSmall);
                          },
                        ),
                        subTitleText("+tax ${double.parse(data.taxVat)}%")
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
      if (localData.data.addons.data.isNotEmpty)
        Selector<CartController, Object>(
          selector: (context, provider) => provider.cartSubTotal,
          builder: (context, value, child) {
            return Row(
              children: [
                for (var addons in localData.data.addons.data)
                  if (addons.quantity > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '${data.addons.data.firstWhere((element) => element.id == addons.id).name}  ${addons.quantity}x${data.addons.data.firstWhere((element) => element.id == addons.id).price}',
                        style: TextStyle(
                            fontSize: fontVerySmall, color: primaryTextColor),
                      ),
                    )
              ],
            );
          },
        ),
      Divider(
        color: secondaryTextColor.withOpacity(0.18),
        thickness: 1,
      )
    ],
  );
}
