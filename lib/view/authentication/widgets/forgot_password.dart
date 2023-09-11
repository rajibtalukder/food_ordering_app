
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view_model/auth_controller.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';
import '../../global_widgets/custom_button.dart';
import 'custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  bool isEmailVerified = true;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please enter your email address",
            style: TextStyle(
              fontSize: 22.sp,
              color: primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          customTextField(
            emailController,
            "Enter Email",
            iconName: "mail.png",
            errorText: "Invalid Email",
            isValid: isEmailVerified,
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: () async {
              isEmailVerified = Utils.isEmailValid(emailController.text);
              if (!isEmailVerified) {
                setState(() {});
              } else {
                Provider.of<AuthController>(context, listen: false)
                    .forgotPassword(context, emailController.text);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: customButton(text: "Send"),
          ),
        ],
      ),
    );
  }
}
