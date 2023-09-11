import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../global_widgets/texts.dart';
import '../../../view_model/home_controller.dart';
import '../bottom_sheet.dart';
import 'allergies.dart';

SliverList categoryList(BuildContext context, int index) {
  var pro = Provider.of<HomeController>(context, listen: false);
  var data = pro.menuItem!.data[index].foods.data;
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return GestureDetector(
          onTap: () {
            pro.getMenuDetails(context, data[index].slug);
            bottomSheet(context, data[index].slug);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(6.w, 0.h, 6.w, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              // boxShadow: [
              //   BoxShadow(
              //     color: secondaryTextColor.withOpacity(0.15),
              //     spreadRadius: 1,
              //     offset: const Offset(3, 3),
              //     blurRadius: 10,
              //   )
              // ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 6.h),
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              data[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: fontMedium,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 156.w,
                            child: subTitleText(data[index].description,
                                usePrimaryFont: true),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 235.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleText("${pro.generalSetting == null ? "£" : pro.generalSetting!.currencySymbol}${data[index].price}",
                                    size: fontSmall,
                                    color: primaryColor,
                                    usePrimaryFont: true),
                                allergiesList(
                                  [
                                    for (int i = 0;
                                        i < data[index].allergies.data.length;
                                        i++)
                                      data[index].allergies.data[i].image
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6.h),
                        ],
                      ),
                    ),
                    Container(
                      height: 90.h,
                      width: 90.h,
                      padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
                      //constraints: BoxConstraints(maxHeight: 90.h, maxWidth: 90.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          data[index].image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
                            color: Colors.grey,
                            height: 90.h,
                            width: 90.h,
                          ),
                        ),
                      ),
                    ),

                    //SizedBox(width: 10.w)
                  ],
                ),
                if(index!=data.length-1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(thickness: 1,color: borderColor.withOpacity(0.8)),
                  ),
              ],
            ),
          ),
        );
      },
      childCount: pro.menuItem == null ? 0 : data.length,
    ),
  );
}
