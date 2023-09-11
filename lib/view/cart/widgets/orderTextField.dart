import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Widget orderTextField(TextEditingController controller, String text, int radius,
    {String? iconName, String? sufIconName, Function(String)? sufActivity, TextInputType? textInputType}) {
  return TextField(
    controller: controller,
    keyboardType: textInputType ?? TextInputType.text,
    onChanged: (v) {
      if (sufActivity != null) {
        sufActivity(v);
      }
    },
    decoration: InputDecoration(
      filled: true,
      hintText: text,
      fillColor: Colors.white,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.sp),
        borderSide: const BorderSide(
          width: 1,
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.sp),
        borderSide: const BorderSide(
          width: 1,
          color: borderColor,
        ),
      ),
      contentPadding: EdgeInsets.all(10.h),
      hintStyle: TextStyle(
        color: secondaryTextColor,
        fontSize: fontSmall,
      ),

      prefixIcon: iconName == null
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Image.asset(
                      "assets/$iconName",
                    ),
                  ),
                ],
              ),
            ),
      suffixIcon: sufIconName == null
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: SizedBox(
                      height: 20.h,
                      child: GestureDetector(
                        onTap: (){
                          sufActivity!("");
                        },
                        child: Image.asset(
                          "assets/$sufIconName",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

      // prefixIconConstraints:
      //     BoxConstraints(maxHeight: 24.h, maxWidth: 24.w),
    ),
    style: const TextStyle(
      height: 1,
    ),
  );
}
