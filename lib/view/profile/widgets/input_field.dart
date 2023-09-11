
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Widget inputField(String labelText, IconData icon, TextEditingController con) {
  return Container(
    height: 60.h,
    padding: EdgeInsets.only(bottom: 10.h),
    child: TextFormField(
      controller: con,
      style: TextStyle(fontSize: fontSmall, color: primaryTextColor),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        prefixIcon: Icon(icon, color: secondaryTextColor),
        //hintText: "Enter Address",
        labelText: labelText,
        labelStyle: const TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.r),
          borderSide: BorderSide(color: secondaryTextColor.withOpacity(0.3)),
        ),
        hintStyle:
            TextStyle(fontSize: fontVerySmall, color: secondaryTextColor),
      ),
    ),
  );
}
