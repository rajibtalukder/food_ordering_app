import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view/global_widgets/custom_button.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/auth_controller.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();

  Timer? _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    code1.dispose();
    code2.dispose();
    code3.dispose();
    code4.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    var pro = Provider.of<AuthController>(context, listen: false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (pro.counter > 0) {
        pro.changeCount();
      } else {
        _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<AuthController>(context, listen: false);

    var otoAddress = pro.authenticatedUser.data!.verifyField == 'email'
        ? pro.authenticatedUser.data!.email
        : pro.authenticatedUser.data!.verifyField == 'phone'
            ? pro.authenticatedUser.data!.phone
            : '';
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleText('Verification', size: fontMedium),
            titleText('We have sent code your:', color: primaryTextColor),
            titleText(otoAddress.replaceRange(2, 5, '***'),
                size: fontMedium, color: primaryTextColor),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                codeInput(code1),
                codeInput(code2),
                codeInput(code3),
                codeInput(code4),
              ],
            ),
            SizedBox(height: 20.h),
            Selector<AuthController, Object>(
              selector: (context, provider) => provider.counter,
              builder: (context, value, child) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (pro.counter != 0) return;
                        pro.counter = 60;
                        _startTimer();
                        await pro.resendCode(context);
                      },
                      child: titleText('Didn\'t receive code? Resend',
                          size: fontMedium,
                          color: pro.counter == 0
                              ? primaryColor
                              : secondaryTextColor,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 5.h),
                    subTitleText('You can request after ${pro.counter} second'),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () async {
                final inputOtp =
                    "${code1.text}${code2.text}${code3.text}${code4.text}";
                print(inputOtp);
                await Provider.of<AuthController>(context, listen: false)
                    .getVerify(context, inputOtp)
                    .then(
                  (value) {
                    if (value) {
                      Navigator.of(context).pushReplacementNamed('CustomNavigation');
                    }
                  },
                );
              },
              child: customButton(text: 'Verify Account'),
            )
          ],
        ),
      ),
    );
  }

  codeInput(TextEditingController controller) {
    return SizedBox(
      height: 80.h,
      width: 50.w,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        controller: controller,
        maxLength: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        )),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
