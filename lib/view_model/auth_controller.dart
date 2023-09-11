import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:klio/model/authenticated_user.dart';
import '../constants/constants.dart';
import '../service/api_client.dart';
import '../utils/shared_preferences.dart';
import '../utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController with ChangeNotifier {
  bool isLoading = false;

  // _changeLoadingState(bool value) {
  //   isLoading = value;
  //   notifyListeners();
  // }

  ///SignIn
  bool isEmailOrPhoneValid = true;
  bool isPasswordValid = true;

  validateLogIn(String email, String pass) {
    isEmailOrPhoneValid = Utils.isEmailValid(email);
    isPasswordValid = Utils.isPasswordValid(pass);

    notifyListeners();
  }

  ///SignUp
  bool isNameValid = true;
  bool isNumberValid = true;
  bool isSignInPasswordValid = true;
  bool isSignInConfirmPasswordValid = true;
  bool isPasswordMatch = true;

  validateSignIn(String name, String phone, String pass, String confirmPass) {
    isSignInPasswordValid = Utils.isPasswordValid(pass);
    isSignInConfirmPasswordValid = Utils.isPasswordValid(confirmPass);
    isPasswordMatch = pass == confirmPass;
    isNumberValid = Utils.validatePhone(phone);
    isNameValid = name.isNotEmpty;
    notifyListeners();
  }

  AuthenticatedUser authenticatedUser = AuthenticatedUser();

  /// verify page
  int counter = 60;

  changeCount() {
    counter--;
    notifyListeners();
  }

  /// end of ui control --------------------------------------------------------------

  Future<bool> login(BuildContext context, String email, String pass) async {
    Utils().showLoadingIndicator(context);
    validateLogIn(email, pass);
    if (!isPasswordValid || !isEmailOrPhoneValid) return false;
    var body = {
      "email": email,
      "password": pass,
    };
    var response = await ApiClient()
        .post('login', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"], context);
    await SharedPref().saveValue('token', jsonDecode(response)["token"]);
    token = jsonDecode(response)['token'];
    return true;
  }

  Future<bool> logOut(BuildContext context) async {
    Utils().showLoadingIndicator(context);
    var response = await ApiClient()
        .post('logout', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    print(token);
    print(Utils().apiHeader);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"], context);
    await SharedPref().saveValue('token', '');
    token = '';
    return true;
  }

  Future<bool> signUp(BuildContext context, String name, String email,
      String phone, String pass, String confirmPass) async {
    Utils().showLoadingIndicator(context);
    validateSignIn(name, phone, pass, confirmPass);
    if (!isPasswordValid || !isEmailOrPhoneValid) return false;
    var body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": confirmPass,
      //'token': token,
    };
    var response = await ApiClient()
        .post('register', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"], context);
    await SharedPref().saveValue('token', jsonDecode(response)["token"]);
    token = jsonDecode(response)['token'];
    Utils.hideLoading(context);
    print(token);
    return true;
  }

  Future<bool> resendCode(BuildContext context) async {
    var response = await ApiClient()
        .post('email/verification-notification', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    print(token);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)[1], context);
    return true;
  }

  Future<bool> getAuthenticatedUser(BuildContext context) async {
    String endPoint = 'user';
    var response = await ApiClient()
        .get(endPoint, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    print(response);
    print(token);
    authenticatedUser = authenticatedUserFromJson(response);
    return true;
  }

  Future<bool> getVerify(BuildContext context, otp) async {
    var body = {"otp_code": otp};
    var response = await ApiClient()
        .post('verify', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    print(token);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"], context);
    return true;
  }

  Future<bool> googleSignIn(BuildContext context) async {

    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
    var result = await googleSignIn.signIn();
      print(result);
      print('result printed');
      if (result == null) return false;
      Utils().showLoadingIndicator(context);
      var response = await ApiClient()
          .post('register',
              payloadObj: {
                "name": result.displayName,
                "email": result.email,
                "google_id": result.id,
              },
              header: Utils().apiHeader)
          .catchError((e) {
        Utils.showSnackBar(e.message, context, title: "An error occurred");
      });
      Utils.hideLoading(context);
      if (response == null) return false;
      print(response);
      print('response printed');
      Utils.showSnackBar(jsonDecode(response)["message"], context);
      await SharedPref().saveValue('token', jsonDecode(response)["token"]);
      token = jsonDecode(response)['token'];
      return true;
    } catch (error) {
      print("--------------------------------error");
      print(error);
      print("---------------------------------- error");
      Utils.showSnackBar("Something went wrong", context);
      return false;
    }
  }

  Future<bool> forgotPassword(BuildContext context, String email) async {
    Utils().showLoadingIndicator(context);
    var response = await ApiClient()
        .post('forgot-password',
            payloadObj: {"email": email}, header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    Utils.hideLoading(context);
    if (response == null) return false;
    Utils.showSnackBar(jsonDecode(response)["message"], context);
    return true;
  }
}
