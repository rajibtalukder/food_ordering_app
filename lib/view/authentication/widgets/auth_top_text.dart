import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Widget authTopText(String text1, String text2) {
  return Column(
    children: [
      Text(
        text1,
        style: secondaryTextStyle(
          30.sp,
          primaryTextColor,
          FontWeight.w800,
        ),
      ),
      SizedBox(width: 310.w),
      SizedBox(
        width: 230.w,
        child: Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSmall,
            color: secondaryTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
