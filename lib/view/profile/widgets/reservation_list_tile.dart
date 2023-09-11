import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view_model/profile_controller.dart';

import '../../../constants/colors.dart';
import '../../global_widgets/texts.dart';

Widget reservationListTile(ProfileController pro, int index) {
  // String date = "${pro.reservationUserData?.data[index].expectedDate}"
  //     .replaceRange(
  //         9,
  //         pro.reservationUserData!.data[index].expectedDate.toString().length -
  //             1,
  //         '');
  //String time ="${pro.reservationUserData?.data[index].expectedDate}"

  return SizedBox(
    height: 70,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              color: white,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText(pro.reservationUserData?.data[index].invoice ?? "",
                      fontWeight: FontWeight.w600, size: 10.sp),
                  SizedBox(width: 10.w),
                  titleText(
                      pro.reservationUserData?.data[index].totalPerson
                              .toString() ??
                          "",
                      fontWeight: FontWeight.w600,
                      size: 10.sp),
                  SizedBox(width: 10.w),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 10.w),
                      titleText("${pro.reservationUserData?.data[index].expectedDate} / ${pro.reservationUserData?.data[index].expectedTime}",
                          fontWeight: FontWeight.w600, size: 10.sp),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  titleText(pro.reservationUserData?.data[index].status??
                      "",
                      fontWeight: FontWeight.w600, size: 10.sp, color: red),
                ],
              )),
          Divider(
            color: borderColor,
            thickness: 1,
          )
        ],
      ),
    ),
  );
}
