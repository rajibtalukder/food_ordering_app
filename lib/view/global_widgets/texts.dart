import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import '../../constants/fonts_constants.dart';

Widget titleText(String text,
    {double size = 22,
    Color color = primaryTextColor,
    FontWeight fontWeight = FontWeight.w800,
    bool usePrimaryFont = false}) {
  return Text(
    text,
    style: usePrimaryFont
        ? TextStyle(
            fontSize: size.sp,
            color: color,
            fontWeight: fontWeight,
          )
        : secondaryTextStyle(
            size.sp,
            color,
            fontWeight,
          ),
  );
}

Widget subTitleText(String text,
    {double size = 12,
    Color color = secondaryTextColor,
    FontWeight fontWeight = FontWeight.w400,
    bool usePrimaryFont = false}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: usePrimaryFont
        ? TextStyle(
            fontSize: size.sp,
            color: color,
            fontWeight: fontWeight,
          )
        : secondaryTextStyle(
            size.sp,
            color,
            fontWeight,
          ),
  );
}
