import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Container outlineButton({required String logoName, required String text}) {
  return Container(
    height: 40.h,
    width: 127.w,
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(20.sp),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 16.h, width: 16.w, child: Image.asset("assets/$logoName")),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
            fontSize: fontVerySmall,
            color: const Color(0xff434343),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
