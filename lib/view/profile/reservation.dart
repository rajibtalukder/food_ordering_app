import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view/profile/widgets/reservation_list_tile.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/fonts_constants.dart';
import '../../view_model/profile_controller.dart';

class Reservation extends StatelessWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation',
            style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
        elevation: 0.0,
        leading: BackButton(color: primaryTextColor),
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //Divider(color: borderColor,thickness: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
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
                          titleText('Invoice',fontWeight: FontWeight.w700,size: fontTiny),
                          SizedBox(width: 20.w),
                          titleText('Person',fontWeight: FontWeight.w700,size: fontTiny),
                          SizedBox(width: 20.w),
                          titleText('Date/Time',fontWeight: FontWeight.w700,size: fontTiny),
                          SizedBox(width: 20.w),
                          titleText('Status',fontWeight: FontWeight.w700,size: fontTiny),
                        ],
                      )),
                  Divider(color: secondaryTextColor,thickness: 1),
                ],
              ),
            ),
            for(var i=0; i<pro.reservationUserData!.data.length;i++)
              reservationListTile(pro, i)
          ],
        ),
      )
    );
  }
}
