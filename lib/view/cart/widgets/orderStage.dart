import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';

import '../../../constants/fonts_constants.dart';
import '../../global_widgets/texts.dart';

Widget orderStage(String title, Color color, Color numberClr) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleText(title, size: fontVeryBig),
      SizedBox(
        width: 190.w,
        height: 48.h,
        child: Stack(
          children: [
            Positioned(
              top:2.h,
              child: Text(
                  '---------------------------------------------',
                  style: TextStyle(
                    color: secondaryTextColor.withOpacity(0.4),
                  ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                serialNum('1', white, primarySwatch, 'Menu'),
                SizedBox(width: 22.w),
                serialNum('2', white, primarySwatch, 'Cart'),
                SizedBox(width: 17.w),
                serialNum('3', numberClr, color, 'Checkout'),
              ],
            ),
          ],
        ),
      )
    ],
  );
}

Widget serialNum(String number, Color numColor, Color bgColor, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 26.h,
        width: 26.h,
        decoration: BoxDecoration(
            border: Border.all(color: primarySwatch, width: 1),
            color: bgColor,
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: numColor,
              fontSize: fontVerySmall,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const Spacer(),
      Text(title, style: TextStyle(fontSize: 10.sp)),
    ],
  );
}
