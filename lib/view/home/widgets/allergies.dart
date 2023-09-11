
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget allergiesList(List<String> allergies){
  return SizedBox(
    height: 14.h,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (String item in allergies)
          Padding(
            padding:  EdgeInsets.only(right: 5.sp),
            child: SizedBox(
              height: 15.h,
              width: 15.w,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Image.network(
                  item,
                  fit: BoxFit.contain,
                  errorBuilder: (context, _, __) => Container(
                    color: Colors.grey,
                    height: 15.h,
                    width: 15.w,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}