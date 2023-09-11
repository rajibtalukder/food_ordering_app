import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/fonts_constants.dart';
import '../../global_widgets/texts.dart';

Widget loginAcInfo(){
  return  Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            height: 30.h,
            width: 30.h,
            child: Image.asset('assets/profile.png'),
          ),
          SizedBox(width: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText('Zawad Ahmed',size: fontSmall),
              Text('01644121340',style:TextStyle(fontSize: fontSmall)),
            ],
          )
        ],
      )
  );
}