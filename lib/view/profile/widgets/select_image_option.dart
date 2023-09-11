
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/profile_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';

Widget selectImageOption(BuildContext context) {
  var pro = Provider.of<ProfileController>(context, listen: false);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SizedBox(height: 10.h),
        titleText('Choose one',color: primaryTextColor,size: fontMedium,),
        ListTile(
          onTap: () {
            pro.pickedImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
          title: const Text('Camera', style: TextStyle(color: primaryTextColor)),
          leading: const Icon(Icons.camera_alt_outlined, color: primaryColor),
        ),
        ListTile(
          onTap: () {
            pro.pickedImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
          title: const Text('Gallery', style: TextStyle(color: primaryTextColor)),
          leading: const Icon(
            Icons.photo,
            color: primaryColor,
          ),
        ),
      ],
    ),
  );
}