import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:klio/view_model/profile_controller.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_constants.dart';
import '../../cart/widgets/orderTextField.dart';
import '../../global_widgets/custom_button.dart';

Future<void> confirmReservation(BuildContext context) {
  var pro = Provider.of<ProfileController>(context, listen: false);
  var data = pro.userProfileData == null ? null : pro.userProfileData!.data;
  TextEditingController nameController = TextEditingController(
      text: data == null ? "" : "${data.firstName} ${data.lastName}");
  TextEditingController emailController =
      TextEditingController(text: data == null ? "" : data.email);
  TextEditingController occasionController = TextEditingController();
  TextEditingController spacialRequestController = TextEditingController();
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.sp),
            topRight: Radius.circular(30.sp),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20.w, 10.h, 20.w, MediaQuery.of(context).viewInsets.bottom),
          child: Consumer<HomeController>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 30.h),
                    titleText("Confirm Table Reservation",
                        fontWeight: FontWeight.w500),
                    CustomTimer(),
                    SizedBox(height: 30.h),
                    title("Enter your name*"),
                    orderTextField(nameController, "Name", 10),
                    Selector<HomeController, Object>(
                      selector: (context, provider) =>
                          provider.showInvalidSign[0],
                      builder: (context, value, child) {
                        print(provider.showInvalidSign[0]);
                        return provider.showInvalidSign[0]
                            ? title("Name is required", color: red)
                            : SizedBox();
                      },
                    ),
                    SizedBox(height: 20.h),
                    title("Enter your email*"),
                    orderTextField(emailController, "Email", 10, textInputType: TextInputType.emailAddress),
                    Selector<HomeController, Object>(
                      selector: (context, provider) =>
                          provider.showInvalidSign[1],
                      builder: (context, value, child) {
                        print(provider.showInvalidSign[1]);
                        return provider.showInvalidSign[1]
                            ? title("Name is required", color: red)
                            : SizedBox();
                      },
                    ),
                    SizedBox(height: 20.h),
                    title("What is the occasion"),
                    orderTextField(occasionController, "Occasion", 10),
                    SizedBox(height: 20.h),
                    title("Any special request"),
                    orderTextField(spacialRequestController, "Request", 10),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () async {
                        if (nameController.text.isEmpty) {
                          provider.changeValiditySign(0, true);
                          return;
                        } else {
                          provider.changeValiditySign(0, false);
                        }
                        if (emailController.text.isEmpty) {
                          provider.changeValiditySign(1, true);
                          return;
                        } else {
                          provider.changeValiditySign(1, false);
                        }
                        await provider.confirmReservation(
                          context,
                          nameController.text,
                          emailController.text,
                          occasion: occasionController.text.isEmpty
                              ? null
                              : occasionController.text,
                          spacialRequest: spacialRequestController.text.isEmpty
                              ? null
                              : spacialRequestController.text,
                        );

                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: customButton(
                        text: "Confirm Reservation",
                        width: 172.w,
                        fontSize: fontVerySmall,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

Align title(String text, {Color? color}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: subTitleText(text, color: color ?? primaryTextColor),
  );
}

class CustomTimer extends StatefulWidget {
  const CustomTimer({Key? key}) : super(key: key);

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int _seconds = 0;
  int _minutes = 5; // Set initial value to 5

  // The state of the timer (running or not)

  // The timer
  Timer? _timer;

  void _startTimer() {
    setState(() {
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _timer?.cancel();
          }
        }
      });
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return titleText(
      "We're holding this table for you for ${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')} minutes",
      size: fontVerySmall,
      fontWeight: FontWeight.normal,
    );
  }
}
