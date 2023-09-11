
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../../model/order_history.dart';
import '../../../view_model/profile_controller.dart';
import '../../global_widgets/texts.dart';

Widget orderListTile(BuildContext context,Datum data) {
  var pro = Provider.of<ProfileController>(context, listen: false);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: GestureDetector(
      onTap: () {
        pro.getOrderHisDetails(context, data.invoice).then((value) {
          if(value){
            Navigator.of(context).pushNamed("OrderHistoryDetails");
          }
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          color: white,
          elevation: 3,
          child: Row(
            children: [
              SizedBox(
                height: 70.h,
                width: 65.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(data.image, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(data.names,
                        style: TextStyle(
                          fontSize: fontSmall,
                          color: primaryTextColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      titleText('${data.items} items',
                          size: fontVerySmall,
                          color: secondaryTextColor,
                          fontWeight: FontWeight.w500),
                      SizedBox(width: 30.w),
                      titleText(
                        data.dateTime,
                        size: fontVerySmall,
                        color: secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    ),
  );
}
