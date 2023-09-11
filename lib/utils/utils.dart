import 'package:flutter/material.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view/global_widgets/texts.dart';
import '../constants/constants.dart';
import 'custom_loading.dart';

class Utils {
  /*static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }*/
  Map<String, String> apiHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  static void showSnackBar(String message, BuildContext context,
      {String? title, Color? color}) {
    var snackBar = SnackBar(
      backgroundColor: color ?? Colors.black,
      content: Column(
        children: [
          if (title != null)
            titleText(title,
                color: Colors.white,
                size: fontSmall,
                fontWeight: FontWeight.bold),
          Text(
            message.substring(0, message.length < 50 ? null : 50),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool isPasswordValid(String password) {
    if (password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  static bool validatePhone(String? value) {
    RegExp phoneRegex = RegExp(r'^\d{11}$');

    if (value == null || value.isEmpty) {
      return false;
    }

    if (!phoneRegex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  showLoadingIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitDoubleBounce(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven
                      ? primaryColor
                      : primaryColor.withOpacity(0.5),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
