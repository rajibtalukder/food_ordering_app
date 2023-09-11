import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../../model/popular_items_model.dart';
import '../../../view_model/favourite_controller.dart';
import '../../global_widgets/texts.dart';
import '../../home/bottom_sheet.dart';
import '../../home/widgets/allergies.dart';

Widget favouriteItem(
    int index, FavouriteController favPro, BuildContext context) {
  PopularItemsModelDatum data = favPro.favItemList!.data[index];
  var homePro = Provider.of<HomeController>(context, listen: false);
  return Container(
    margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: secondaryTextColor.withOpacity(0.15),
          spreadRadius: 1,
          offset: const Offset(3, 3),
          blurRadius: 10,
        )
      ],
    ),
    child: SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              homePro.getMenuDetails(context, data.slug);
              bottomSheet(context, data.slug);
            },
            child: Container(
              height: 90.h,
              width: 90.h,
              padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
              //constraints: BoxConstraints(maxHeight: 90.h, maxWidth: 90.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  data.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => Container(
                    color: Colors.grey,
                    height: 90.h,
                    width: 90.h,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: (){
                      homePro.getMenuDetails(context, data.slug);
                      bottomSheet(context, data.slug);
                    },
                    child: SizedBox(
                      width: 150.w,

                      child: Text(
                        data.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontMedium,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 156.w,
                    child:
                        subTitleText(data.description, usePrimaryFont: true),
                  ),
                  SizedBox(
                    width: 235.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleText("${homePro.generalSetting == null ? "£" : homePro.generalSetting!.currencySymbol}${data.price}",
                            size: fontSmall,
                            color: primaryColor,
                            usePrimaryFont: true),
                        allergiesList(
                          [
                            for (int i = 0;
                                i < data.allergies.data.length;
                                i++)
                              data.allergies.data[i].image
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                favPro.removeFavouriteItems(data.slug);
              },
              child: SizedBox(
                height: 25.h,
                  width: 25.w,
                  child: Image.asset('assets/delete.png'))),
          SizedBox(width: 10.w),
        ],
      ),
    ),
  );
}
