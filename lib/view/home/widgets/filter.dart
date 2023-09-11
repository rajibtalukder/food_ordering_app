import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';

SizedBox filter(HomeController provider) {
  return SizedBox(
    height: 80.h,
    child: NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return true;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.isLoading && provider.searchController.text.isEmpty
            ? 8
            : provider.filterItems!.length + 1,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 6.w),
        itemBuilder: (context, index) {
          return provider.isLoading && provider.searchController.text.isEmpty
              ? _loadingFilter(context)
              : InkWell(
                  onTap: () {
                    provider.changeSelectedFilter(index == 0
                        ? "Popular"
                        : provider.filterItems![index - 1].label);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.h,
                        height: 50.h,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        //padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(43.r),
                        ),
                        child: index == 0
                            ? Image.asset(
                                "assets/popular.png",
                                fit: BoxFit.cover,
                                color: primaryColor,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(43.r),
                                child: Image.network(
                                  provider.filterItems![index - 1].url!,
                                  color: index == 0 ? primaryColor : null,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 50.w,
                        child: Center(
                          child: Text(
                            index == 0
                                ? "Popular"
                                : provider.filterItems![index - 1].label,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: index == 0
                                    ? provider.selectedFilter == "Popular"
                                        ? primaryTextColor
                                        : secondaryTextColor
                                    : provider.selectedFilter ==
                                            provider
                                                .filterItems![index - 1].label
                                        ? primaryTextColor
                                        : secondaryTextColor),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    ),
  );
}

Widget _loadingFilter(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.h,
          height: 50.h,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: secondaryTextColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(43.r),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 50.h,
          height: 10.h,
          color: secondaryTextColor.withOpacity(0.4),
        )
      ],
    ),
  );
}
