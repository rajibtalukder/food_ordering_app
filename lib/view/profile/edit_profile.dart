import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view/global_widgets/custom_button.dart';
import 'package:klio/view/global_widgets/custom_dialog.dart';
import 'package:klio/view/profile/widgets/input_field.dart';
import 'package:klio/view/profile/widgets/select_image_option.dart';
import 'package:klio/view_model/profile_controller.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProfileController pro;

  @override
  void initState() {
    pro = Provider.of<ProfileController>(context, listen: false);
    pro.getUserProfileData(context);
    super.initState();
  }

  @override
  void dispose() {
    pro.isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileController>(context, listen: false);
    TextEditingController fNameCtlr = TextEditingController(
        text: pro.userProfileData!.data.firstName);
    TextEditingController lNameCtlr = TextEditingController(
        text: pro.userProfileData!.data.lastName);
    TextEditingController emailCtlr = TextEditingController(
        text: pro.userProfileData!.data.email);
    TextEditingController phnCtlr = TextEditingController(
        text: pro.userProfileData!.data.phone);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: const BackButton(color: primaryTextColor),
          elevation: 0.0,
          title: const Text('Edit Profile',
              style: TextStyle(color: primaryTextColor)),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    Selector<ProfileController, Object>(
                        selector: (context, provider) => provider.imagePath,
                        builder: (context, value, child) {
                          return Container(
                              padding: EdgeInsets.all(5.w),
                              height: 150.h,
                              width: 150.h,
                              decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: pro.imagePath == ''
                                    ? Image.network(
                                  pro.userProfileData!.data.image,
                                  fit: BoxFit.cover,
                                )
                                    : Image.file(File(pro.imagePath),
                                    fit: BoxFit.cover),
                              ));
                        }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showCustomDialog(context,
                              widget: selectImageOption(context),
                              heightReduce: 650.h,
                              widthReduce: 100.w);
                        },
                        child: Container(
                          height: 48.h,
                          width: 48.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: white,
                          ),
                          padding: EdgeInsets.all(3.w),
                          child: CircleAvatar(
                            radius: 20.r,
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 20.h),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      inputField(
                        'First Name',
                        Icons.person,
                        fNameCtlr,
                      ),
                      inputField(
                        'Last Name',
                        Icons.person,
                        lNameCtlr,
                      ),
                      inputField(
                        'Email',
                        Icons.mail,
                        emailCtlr,
                      ),
                      inputField(
                        'Phone',
                        Icons.call,
                        phnCtlr,
                      ),
                      SizedBox(height: 20.h),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                              onTap: () async {
                                await pro.updateUserProfile(context, fNameCtlr.text,
                                  lNameCtlr.text, emailCtlr.text, phnCtlr.text,);
                              },
                              child: customButton(text: 'Update Profile')))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
