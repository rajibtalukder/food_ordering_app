import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../../view_model/cart_controller.dart';
import '../../global_widgets/texts.dart';

Widget buildAddress(BuildContext context, CartController pro, int index) {
  return GestureDetector(
    onTap: () {
      pro.changeSelectedAddress(index);
    },
    child: Selector<CartController, Object>(
        selector: (context, provider) => provider.selectAddress,
        builder: (context, value, child) {
          return Container(
            margin: EdgeInsets.all(5.h),
            height: 65.h,
            width: 400.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: pro.selectAddress == index
                      ? Colors.black.withOpacity(0.1)
                      : borderColor,
                  width: pro.selectAddress == index ? 2 : 1,
                ),
                color: pro.selectAddress == index
                    ? primaryColor.withOpacity(0.3)
                    : white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleText(pro.userAddress![index].type,
                          color: primaryTextColor, size: fontSmall),
                      SizedBox(
                        width: 270.w,
                        child: titleText(pro.userAddress![index].location,
                            color: primaryTextColor,
                            size: fontVerySmall,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('EditAddress', arguments: index);
                      pro.singleAddress = pro.userAddress![index];
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
          );
        }),
  );
}
