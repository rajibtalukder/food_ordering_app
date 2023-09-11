import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/fonts_constants.dart';
import '../../model/reservation_time_model.dart';
import '../../view_model/profile_controller.dart';
import '../cart/widgets/orderTextField.dart';
import '../global_widgets/custom_button.dart';

Future<void> tableReservation(BuildContext context) {
  TextEditingController controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 30.h),
                  titleText("Table Reservation", fontWeight: FontWeight.w500),
                  SizedBox(height: 30.h),
                  title("Number of people *"),
                  orderTextField(
                    controller,
                    "People Count",
                    10,
                    sufActivity: (String value) {
                      provider.changeDateDropDownValue("Pick Date");
                      provider.changeTimeDropDownValue("");
                      provider.reservationTime = null;
                    },
                    textInputType: TextInputType.number,
                  ),
                  Selector<HomeController, Object>(
                    selector: (context, provider) =>
                        provider.showInvalidSign[0],
                    builder: (context, value, child) {
                      return provider.showInvalidSign[0]
                          ? title("Need to enter people count", color: red)
                          : SizedBox();
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title("Chose a date *"),
                          GestureDetector(
                            onTap: () async {
                              if (controller.text.isEmpty) {
                                provider.changeValiditySign(0, true);
                                return;
                              }
                              provider.changeValiditySign(0, false);
                              DateTime selectedDate = DateTime.now();
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != selectedDate) {
                                selectedDate = picked;
                                provider.changeDateDropDownValue(
                                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, "0")}-${selectedDate.day.toString().padLeft(2, "0")}");
                                provider.getAvailableSlot(
                                    context, controller.text);
                              }
                            },
                            child: Container(
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: borderColor)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(
                                      provider.dateDropDownValue,
                                      fontWeight: FontWeight.w500,
                                      size: fontSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Selector<HomeController, Object>(
                            selector: (context, provider) =>
                                provider.showInvalidSign[1],
                            builder: (context, value, child) {
                              print(provider.showInvalidSign[1]);
                              return provider.showInvalidSign[1]
                                  ? title("Need to select date", color: red)
                                  : SizedBox();
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title("Chose time *"),
                          Container(
                            height: 50.h,
                            width: 150.w,
                            padding: EdgeInsets.only(left: 6.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: borderColor)),
                            child: DropdownButton<String>(
                              iconEnabledColor: primaryTextColor,
                              value: provider.timeDropDownValue,
                              items: provider.reservationTime == null
                                  ? []
                                  : provider.reservationTime!.map(
                                      (ReservationTimeModel val) {
                                        return DropdownMenuItem<String>(
                                          value: val.time,
                                          enabled: val.available,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5.w, 5.h, 50.w, 5.h),
                                            child: Text(
                                              val.time,
                                              style: TextStyle(
                                                color: val.available
                                                    ? primaryTextColor
                                                    : secondaryTextColor,
                                                fontSize: fontVerySmall,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                              borderRadius: BorderRadius.circular(10),
                              disabledHint: const Text('Disable     '),
                              dropdownColor: white,
                              elevation: 1,
                              underline: SizedBox(),
                              hint: Text(provider.timeDropDownValue,
                                  style: const TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: fontVerySmall),
                              onChanged: (value) {
                                provider.changeTimeDropDownValue(value!);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  title("Enter mobile number *"),
                  orderTextField(numberController, "Number", 10,
                      textInputType: TextInputType.number),
                  Selector<HomeController, Object>(
                    selector: (context, provider) =>
                        provider.showInvalidSign[2],
                    builder: (context, value, child) {
                      return provider.showInvalidSign[2]
                          ? title(
                              numberController.text.length == 0
                                  ? "Need to enter mobile number"
                                  : "number must be 11 character long",
                              color: red)
                          : SizedBox();
                    },
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () async {
                      if (controller.text.isEmpty) {
                        provider.changeValiditySign(0, true);
                        return;
                      } else {
                        provider.changeValiditySign(0, false);
                      }
                      if (provider.dateDropDownValue == "Pick Date") {
                        provider.changeValiditySign(1, true);
                        return;
                      } else {
                        provider.changeValiditySign(1, false);
                      }
                      if (numberController.text.length < 8 || numberController.text.length > 20) {
                        provider.changeValiditySign(2, true);
                        return;
                      } else {
                        provider.changeValiditySign(2, false);
                      }
                      var pro = Provider.of<ProfileController>(context, listen: false);
                      var data = pro.userProfileData == null ? null : pro.userProfileData!.data;
                      await provider.reserveTable(
                          context, controller.text, numberController.text, data?.id.toString() ?? "" );

                      if (provider.reservation != null) {
                        Navigator.of(context).pop();
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: customButton(
                      text: "Reserve",
                      width: 172.w,
                      fontSize: fontVerySmall,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
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
