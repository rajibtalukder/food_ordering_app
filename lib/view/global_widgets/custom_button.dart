import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';

import '../../constants/colors.dart';

Container customButton({
  double? height,
  double? width,
  required String text,
  double? fontSize,
  Color? color,
  String? imageName,
}) {
  return Container(
    height: height ?? 40.h,
    width: width ?? double.infinity,
    decoration: BoxDecoration(
      color: color ?? primaryColor,
      borderRadius: BorderRadius.circular(50.sp),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageName != null)
          SizedBox(
            height: 16.h,
            width: 16.w,
            child: Image.asset(
              "assets/$imageName",
              fit: BoxFit.contain,
            ),
          ),
        if (imageName != null) SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? fontSmall,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

CircleAvatar circleAvatar(IconData iconData , {Color color = primaryColor}) {
  return CircleAvatar(
    backgroundColor: color,
    radius: 12.r,
    child: Icon(
      iconData,
      size: 15.sp,
      color: Colors.white,
    ),
  );
}
