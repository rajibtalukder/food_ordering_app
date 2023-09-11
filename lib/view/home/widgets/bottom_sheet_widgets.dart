import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../view_model/home_controller.dart';
import '../../global_widgets/custom_button.dart';
import '../../global_widgets/texts.dart';

ConstrainedBox buildAddons(HomeController homePro, CartController cartPro) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 200.h),
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: homePro.menuDetails == null
            ? 0
            : homePro.menuDetails!.data.addons.data.length,
        itemBuilder: (BuildContext context, int index) {
          var data = homePro.menuDetails!.data.addons.data;

          return Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: titleText(data[index].name,
                        fontWeight: FontWeight.w500, size: fontVerySmall),
                  ),
                ),
                Expanded(
                  child: Selector<CartController, Object>(
                    selector: (context, provider) =>
                        cartPro.cartItem!.data.addons.data[index].quantity,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cartPro.decreaseQuantity(
                                  isAddons: true, index: index);
                            },
                            child: circleAvatar(Icons.remove),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            cartPro.cartItem!.data.addons.data[index].quantity
                                .toString(),
                            style: TextStyle(fontSize: fontMedium),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                              cartPro.increaseQuantity(
                                  isAddons: true, index: index);
                            },
                            child: circleAvatar(Icons.add),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Center(
                    child: titleText("${homePro.generalSetting == null ? "£" : homePro.generalSetting!.currencySymbol}${data[index].price}",
                        size: fontVerySmall, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        }),
  );
}

Padding buildVariants(HomeController pro, CartController cartPro) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleText("Select Variants:",
            size: fontSmall, fontWeight: FontWeight.bold),
        Container(
          height: 40.h,
          width: 110.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: secondaryTextColor, width: 1)),
          child: Selector<CartController, Object>(
            selector: (context, provider) =>
                provider.cartItem!.data.selectedVariants,
            builder: (context, value, child) {
              return DropdownButton<String>(
                items: pro.menuDetails!.data.variants.data.map((dynamic val) {
                  return DropdownMenuItem<String>(
                    value: val.name.toString(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(val.name,
                          style: TextStyle(
                              color: primaryTextColor,
                              fontSize: fontVerySmall)),
                    ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(30),
                underline: const SizedBox(),
                isExpanded: true,
                dropdownColor: Colors.white,
                value: cartPro.cartItem!.data.selectedVariants,
                onChanged: (value) {
                  var temp = pro.menuDetails!.data.variants.data
                      .firstWhere((element) => element.name == value);
                  cartPro.selectVariants(temp.name, temp.id);
                },
              );
            },
          ),
        )
      ],
    ),
  );
}

Padding buildCartButton(
    String slug, CartController pro, bool isUpdate, BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            pro.decreaseQuantity(isAddons: false);
          },
          child: circleAvatar(Icons.remove),
        ),
        SizedBox(width: 10.w),
        Selector<CartController, Object>(
            selector: (context, provider) => provider.cartItem!.data.quantity,
            builder: (context, value, child) {
              return titleText(pro.cartItem!.data.quantity.toString(),
                  size: fontBig, fontWeight: FontWeight.bold);
            }),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            pro.increaseQuantity(isAddons: false);
          },
          child: circleAvatar(Icons.add),
        ),
        SizedBox(width: 10.w),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            if (isUpdate) {
              return;
            }
            pro.addCartItems();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: customButton(
              text: isUpdate ? "Done" : "Add To Cart",
              width: 172.w,
              fontSize: fontVerySmall,
              imageName: isUpdate ? null : "addToCart.png"),
        )
      ],
    ),
  );
}
