import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/authentication/widgets/auth_top_text.dart';
import 'package:klio/view/authentication/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/fonts_constants.dart';
import '../../view_model/auth_controller.dart';
import '../../view_model/home_controller.dart';
import '../global_widgets/custom_app_bar.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/drawer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isAgreed = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      key: pro.signUpScaffoldKey,
      appBar: customAppBar(context),
      drawer: sideDrawer(false, context),
      onDrawerChanged: (value) {
        pro.changeDrawerState(value);
      },
      body: SizedBox(
        height: 728.h,
        width: 390.w,
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 20.h),
              authTopText("Sign Up",
                  "Enter your details to Sign Up to your user account"),
              SizedBox(height: 32.h),
              Consumer<AuthController>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      customTextField(
                        nameController,
                        "User name",
                        iconName: "person.png",
                        isValid: provider.isNameValid,
                        errorText: "Enter a name",
                      ),
                      SizedBox(height: 16.h),
                      customTextField(
                        phoneController,
                        "Phone Number",
                        iconName: "phone.png",
                        isValid: provider.isNumberValid,
                        errorText: "Invalid Number",
                      ),
                      SizedBox(height: 16.h),
                      customTextField(
                        emailController,
                        "Email",
                        iconName: "mail.png",
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child: Text(
                            "Optional Field",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48.h),
                      customTextField(
                        passwordController,
                        "Password",
                        iconName: "eye.png",
                        isValid: provider.isSignInPasswordValid
                            ? provider.isPasswordMatch
                            : false,
                        errorText: provider.isSignInPasswordValid
                            ? provider.isPasswordMatch
                                ? ""
                                : "Password did not match"
                            : "Invalid Password",
                      ),
                      SizedBox(height: 16.h),
                      customTextField(
                        confirmPasswordController,
                        "Confirm Password",
                        iconName: "eye.png",
                        isValid: provider.isSignInConfirmPasswordValid
                            ? provider.isPasswordMatch
                            : false,
                        errorText: provider.isSignInConfirmPasswordValid
                            ? provider.isPasswordMatch
                                ? ""
                                : "Password did not match"
                            : "Invalid Password",
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isAgreed,
                      onChanged: (checked) {
                        setState(() {
                          isAgreed = checked ?? false;
                        });
                      }),
                  Text(
                    "I have agreed to ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: primaryTextColor,
                    ),
                  ),
                  Text(
                    "Term and condition",
                    style: TextStyle(
                      fontSize: fontVerySmall,
                      fontWeight: FontWeight.w700,
                      color: primaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  await Provider.of<AuthController>(context, listen: false)
                      .signUp(
                          context,
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          passwordController.text,
                          confirmPasswordController.text)
                      .then((value) async {
                    if (value) {
                      await Provider.of<AuthController>(context, listen: false)
                          .getAuthenticatedUser(context);
                      Navigator.of(context).pushNamed('Verification');
                    }
                    return;
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: customButton(text: "Sign in"),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Member?  ",
                    style: TextStyle(
                      fontSize: fontVerySmall,
                      fontWeight: FontWeight.w500,
                      color: primaryTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("LogIn");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: fontVerySmall,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
