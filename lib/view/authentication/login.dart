import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/authentication/widgets/auth_top_text.dart';
import 'package:klio/view/authentication/widgets/custom_text_field.dart';
import 'package:klio/view/authentication/widgets/forgot_password.dart';
import 'package:klio/view/authentication/widgets/google_verification.dart';
import 'package:klio/view/authentication/widgets/outline_button.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/fonts_constants.dart';
import '../../view_model/auth_controller.dart';
import '../global_widgets/custom_app_bar.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/custom_dialog.dart';
import '../global_widgets/drawer.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<HomeController>(context, listen: false);
    var authProvider = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      key: pro.logInScaffoldKey,
      appBar: customAppBar(context, menuBtnOff: true),
      drawer: sideDrawer(false, context),
      onDrawerChanged: (value) {
        pro.changeDrawerState(value);
      },
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 728.h,
          width: 390.w,
          child: Padding(
            padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45.h),
                const Spacer(),
                authTopText("User Login",
                    "Enter your details to sign in to your user account"),
                SizedBox(height: 48.h),
                Consumer<AuthController>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        customTextField(
                          emailController,
                          "Enter Email/ Phone No",
                          iconName: "mail.png",
                          isValid: provider.isEmailOrPhoneValid,
                          errorText: "Invalid Email/Phone",
                        ),
                        SizedBox(height: 22.h),
                        customTextField(
                          passwordController,
                          "Password",
                          iconName: "eye.png",
                          isValid: provider.isPasswordValid,
                          errorText: "Invalid Password",
                          obscureText: true,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 48.h),
                InkWell(
                  onTap: () async {
                    emailController.text = "user@gmail.com";
                    passwordController.text = "12345678";
                    Provider.of<AuthController>(context, listen: false)
                        .login(context, emailController.text,
                            passwordController.text)
                        .then(
                      (value) {
                        if (value) {
                          Navigator.of(context)
                              .pushReplacementNamed("CustomNavigation");
                        }
                        return;
                      },
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: customButton(text: "Login"),
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "—  or sign in with  —",
                    style: secondaryTextStyle(
                      fontVerySmall,
                      primaryTextColor,
                      FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    outlineButton(logoName: "fb.png", text: "Facebook"),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        authProvider.googleSignIn(context).then((value) async {
                          if (value) {
                            if (value) {
                              Navigator.of(context)
                                  .pushReplacementNamed("CustomNavigation");
                            }
                          }
                          return;
                        });
                      },
                      child:
                          outlineButton(logoName: "google.png", text: "Google"),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(context,
                            widget: ForgotPassword(),
                            heightReduce:
                                MediaQuery.of(context).size.height * 0.6,
                            widthReduce:
                                MediaQuery.of(context).size.width * 0.1);
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor,
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
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("SignUp");
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
