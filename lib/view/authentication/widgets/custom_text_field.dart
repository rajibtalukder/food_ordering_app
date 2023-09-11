import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

border(bool isValid) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.sp),
      borderSide: BorderSide(
        width: 1,
        color: !isValid ? red.withOpacity(0.3) : borderColor,
      ),
    );

Widget customTextField(TextEditingController controller, String text,
    {String? iconName,
    bool obscureText = false,
    bool? isValid,
      bool? isKeyboardPhone,
    String? errorText}) {
  return Column(
    children: [
      TextField(
        controller: controller,
        keyboardType:isKeyboardPhone==true? TextInputType.phone: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: text,
          fillColor: Colors.white,
          border: border(isValid ?? true),
          enabledBorder: border(isValid ?? true),
          focusedBorder: border(isValid ?? true),
          contentPadding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 23.w),
          hintStyle: TextStyle(
            color: secondaryDarkTextColor,
            fontSize: fontSmall,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/$iconName", width: 23.h,
                  // this sets the width of the image to 24 pixels
                  height: 23.h,
                ),
              ],
            ),
          ),
        ),
        style:  const TextStyle(
          height: 1,
        ),
      ),
      if (isValid != null && !isValid)
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Text(
              errorText ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: red,
              ),
            ),
          ),
        ),
    ],
  );
}



/*Widget cuastomTextField(TextEditingController controller, String text,
    {String? iconName,
    bool obscureText = false,
    bool? isValid,
    String? errorText}) {
  return Column(
    children: [
      Container(
        height: 52.h,
        width: 340.w,
        padding: EdgeInsets.fromLTRB(10.w, 0, 20.w, 0),
        decoration: BoxDecoration(
          border: Border.all(
              color: isValid != null && !isValid
                  ? red.withOpacity(0.3)
                  : borderColor),
          borderRadius: BorderRadius.circular(43.sp),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset(
                "assets/$iconName",
              ),
            ),
            suffixIconConstraints:
                BoxConstraints(maxHeight: 24.h, maxWidth: 24.w),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(
              color: secondaryDarkTextColor,
              fontSize: fontSmall,
            ),
          ),
        ),
      ),
      if (isValid != null && !isValid)
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Text(
              errorText ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: red,
              ),
            ),
          ),
        ),
    ],
  );
}*/
