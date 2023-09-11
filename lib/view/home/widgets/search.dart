import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Widget search( HomeController pro) {
  Timer? searchOnStoppedTyping;
  return Selector<HomeController, Object>(
    selector: (context, provider) => provider.scrolledPixel,
    builder: (context, value, child) {
      return Container(
        height: 52.h - pro.scrolledPixel.h,
        padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 0),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
        decoration: BoxDecoration(
          color: borderColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextFormField(
          controller: pro.searchController,
          onChanged: (text) async {
            const duration = Duration(
                seconds:
                1); // set the duration that you want call search() after that.
            if (searchOnStoppedTyping != null) {
              searchOnStoppedTyping!
                  .cancel(); // clear timer
            }
            searchOnStoppedTyping = Timer(duration, () {
              pro.searchItems(context, text);

            });
          },
          style:  TextStyle(
            color: secondaryTextColor,
            fontSize: (fontSmall - pro.scrolledPixel * 0.32).abs(),
            height: pro.scrolledPixel == 52 ? 0 : 1.2.sp
          ),
          decoration: InputDecoration(
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (24.h - pro.scrolledPixel * 0.461).abs(),
                  height: (24.h - pro.scrolledPixel * 0.461).abs(),
                  child: Image.asset(
                    "assets/search.png",
                  ),
                ),
              ],
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            hintText: " Search Item",

            hintStyle: TextStyle(
              color: secondaryTextColor,
              fontSize: (fontSmall - pro.scrolledPixel * 0.32).abs(),
            ),
          ),
        ),
      );
    },
  );
}
