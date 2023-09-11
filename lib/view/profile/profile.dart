import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view/profile/widgets/order_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/fonts_constants.dart';
import '../../view_model/profile_controller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late var pro;

  @override
  void initState() {
    pro = Provider.of<ProfileController>(context, listen: false);
    pro.getOrderHistory(context);
    pro.getProfileData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: white,
      ),*/
      body: Selector<ProfileController, Object>(
        selector: (context, provider) => provider.isLoading,
        builder: (context, value, child) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
              child: _buildColumn(pro, context),
            ),
          );
        },
      ),
    );
  }

  Column _buildColumn(ProfileController pro, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: Container(color: primaryColor.withOpacity(0.8)),
                ),
              ),
              Positioned(
                left: 130.w,
                top: 100.h,
                child: Selector<ProfileController, Object>(
                  selector: (context, provider) => provider.imagePath,
                  builder: (context, value, child) {
                    return Container(
                      height: 100.h,
                      width: 100.h,
                      padding: EdgeInsets.all(5.w),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: white),
                      child: pro.isLoading
                          ? _loadingCartItem(context)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: pro.userProfileData?.data.image == ''
                                  ? Image.asset(
                                      'assets/profile.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      pro.userProfileData?.data.image ?? "",
                                      fit: BoxFit.cover),
                            ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 60.h,
                child: Column(
                  children: [
                    titleText(pro.userProfileData?.data.firstName != null
                        ? "${pro.userProfileData?.data.firstName} ${pro.userProfileData?.data.lastName}"
                        : "User"),
                    TextButton(
                      child: titleText('Edit Profile',
                          color: primaryColor, size: fontSmall),
                      onPressed: () {
                        Navigator.of(context).pushNamed('EditProfile');
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 50.h,
                child: titleText(
                    'Reward Point : ${pro.userProfileData == null ? "0" : pro.userProfileData?.data.reward}',
                    size: fontSmall,
                    color: secondaryTextColor),
              ),
              Positioned(
                left: 0,
                bottom: 10.h,
                child: titleText('Order History', size: fontMedium),
              )
            ],
          ),
        ),
        Expanded(child: orderHistory(context)),
      ],
    );
  }

  Shimmer _loadingCartItem(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
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
}

Widget orderHistory(BuildContext context) {
  var pro = Provider.of<ProfileController>(context, listen: false);
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: pro.orderHistory == null
        ? SizedBox()
        : Column(
            children: [
              for (int i = 0; i < pro.orderHistory!.data.length; i++)
                orderListTile(context, pro.orderHistory!.data[i])
            ],
          ),
  );
}
