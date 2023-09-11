import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../global_widgets/texts.dart';

Widget textRow(String key, String value){
  return  Padding(
    padding:  EdgeInsets.only(bottom: 10.0.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleText('$key :', color: primaryTextColor, size: fontSmall),
        titleText(value, color: primaryColor, size: fontSmall),
      ],
    ),
  );
}