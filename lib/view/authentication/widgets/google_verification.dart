import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/fonts_constants.dart';
import '../../global_widgets/custom_button.dart';
import '../../global_widgets/texts.dart';
import 'custom_text_field.dart';

Widget googleVerification(){
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(height: 10.h),
        SizedBox(height: 15.h),
        titleText('Verify phone number',size: fontBig, fontWeight: FontWeight.w600),
        SizedBox(height: 30.h),
        customTextField(isKeyboardPhone: true,
          TextEditingController(),
          "Enter your phone number",
          iconName: "phone.png",
          errorText: "Invalid Password",
          obscureText: true,
        ),
        SizedBox(height: 30.h),
        customButton(text: 'Verify'),
      ],
    ),
  );
}