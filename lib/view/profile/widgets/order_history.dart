import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/constants/fonts_constants.dart';

import '../profile.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order History',
              style: TextStyle(color: primaryTextColor, fontSize: fontBig)),
          centerTitle: true,
          backgroundColor: white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          // iconTheme: IconThemeData(
          //   color: primaryTextColor, //change your color here
          // ),
        ),
        body: Container(
            padding: EdgeInsets.all(10.h),
            height: 800.h,
            child: orderHistory(context)));
  }
}
