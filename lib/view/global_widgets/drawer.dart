import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/auth_controller.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/constants.dart';
import '../../constants/fonts_constants.dart';
import '../../utils/shared_preferences.dart';
import '../../view_model/profile_controller.dart';

Widget sideDrawer(bool isLoggedIn, BuildContext context) {
  var pro = Provider.of<ProfileController>(context, listen: false);
  return Selector<ProfileController, Object>(
      selector: (context, provider) => provider.isLoading,
      builder: (context, value, child) {
        return Drawer(
          width: 223.w,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: 844.h,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 58.h, 16.w, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120.h,
                        height: 120.h,
                        child:pro.isLoading?_loadingProfilePic(context): ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.network(
                              fit: BoxFit.cover,
                              pro.userProfileData?.data.image ?? ""),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                   pro.isLoading? _loadingText(context): titleText(
                      isLoggedIn ?"${pro.userProfileData?.data.firstName??''} ${pro.userProfileData?.data.lastName??''}": "You Must Login First",
                      size: fontSmall,
                      fontWeight: FontWeight.w700,
                      usePrimaryFont: true,
                    ),
                    SizedBox(height: 4.h),
                    !isLoggedIn
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: fontTiny,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                height: 12.h,
                                width: 1.w,
                                color: Colors.black,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                    fontSize: fontTiny,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        :pro.isLoading? _loadingText(context): titleText(
                            pro.userProfileData?.data.phone??'',
                            size: fontSmall,
                            fontWeight: FontWeight.w400,
                            usePrimaryFont: true,
                          ),
                    SizedBox(height: 12.h),
                    const Divider(color: secondaryTextColor),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed('OrderHistory');
                        },
                        child: row("order.png", "Order")),
                    GestureDetector(
                      onTap: (){
                        pro.getReservationUserData(context).then((value) {
                          if(value){
                            Navigator.of(context).pushNamed('Reservation');
                          }
                        });
                      },
                        child: row("reward.png", "Reservation")),
                    // row("voucher.png", "Voucher"),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('Profile');
                      },
                        child: row("drawerProfile.png", "Profile")),
                    SizedBox(height: 24.h),
                    const Divider(color: secondaryTextColor),
                    const Spacer(),
                    // titleText(
                    //   "Settings",
                    //   size: fontVerySmall,
                    //   fontWeight: FontWeight.w400,
                    //   usePrimaryFont: true,
                    // ),
                    // SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('TermsAndConditions');
                      },
                      child: titleText(
                        "Terms & Condition ",
                        size: fontVerySmall,
                        fontWeight: FontWeight.w400,
                        usePrimaryFont: true,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () async {
                        await Provider.of<AuthController>(context,
                            listen: false)
                            .logOut(context)
                            .then(
                              (value) async {
                            if (value) {
                              SharedPref().saveList("favourites", []);
                              SharedPref().saveList('carts', []);
                              SharedPref().saveValue('token', "");
                              Provider.of<HomeController>(context,
                                  listen: false)
                                  .changeDrawerState(false);
                              Navigator.of(context)
                                  .pushReplacementNamed("LogIn");
                            }
                            return;
                          },
                        );

                      },
                      child: titleText(
                        "Log Out",
                        size: fontVerySmall,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                        usePrimaryFont: true,
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Padding row(String imageName, String text) {
  return Padding(
    padding: EdgeInsets.only(top: 16.h),
    child: Row(
      children: [
        SizedBox(
          width: 18.w,
          height: 17.h,
          child: Image.asset(
            "assets/$imageName",
            color: primaryColor,
          ),
        ),
        SizedBox(width: 14.w),
        titleText(
          text,
          size: fontVerySmall,
          fontWeight: FontWeight.w700,
          usePrimaryFont: true,
        ),
      ],
    ),
  );
}

Shimmer _loadingProfilePic(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: secondaryTextColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}

Shimmer _loadingText(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Container(
      height: 16.h,
      width: 150.w,
      decoration: BoxDecoration(
        color: secondaryTextColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}
