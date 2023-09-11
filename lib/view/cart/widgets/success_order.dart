import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../../utils/shared_preferences.dart';
import '../../../view_model/cart_controller.dart';
import '../../global_widgets/custom_button.dart';

Widget successOrder(String message, BuildContext context) {
  var pro = Provider.of<CartController>(context, listen: false);
  return Padding(
    padding: EdgeInsets.all(20.0.h),
    child: Column(
      children: [
        Container(
          height: 180.h,
          width: 180.h,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: Container(
              height: 140.h,
              width: 140.h,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: const Icon(Icons.done, color: white, size: 100),
            ),
          ),
        ),
        Spacer(),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSmall,
            color: primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: (){
            pro.localCartItems = [];
            pro.cartItemList = null;
            SharedPref().saveList('carts', []);
            Navigator.of(context)
                .pushReplacementNamed("CustomNavigation");
          },
          child: customButton(text: 'Order More?', width: 200.w),
        ),
      ],
    ),
  );
}
