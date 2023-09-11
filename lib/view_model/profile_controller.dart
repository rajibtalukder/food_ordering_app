import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klio/model/order_history_details_model.dart';
import 'package:klio/model/reservation_user_data_model.dart';
import 'package:klio/model/user_profile_model.dart';
import 'package:klio/service/api_client.dart';
import 'package:klio/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../model/order_history.dart';
import '../service/api_exception.dart';

class ProfileController extends ChangeNotifier {
//start image picker for get profile picture.....
  var imagePath = '';
  final ImagePicker picker = ImagePicker();
  bool isLoading = true;
  OrderHistoryModel? orderHistory;
  OrderHistoryDetailsModel? orderHisModel;
  ReservationUserData? reservationUserData;

  void pickedImage(ImageSource imgCam) async {
    final XFile? image = await picker.pickImage(source: imgCam);
    imagePath = image!.path;
    notifyListeners();
  }

//end image picker for get profile picture.....

  getProfileData(BuildContext context) {
    Future.wait([
      getUserProfileData(context, shouldNotify: false),
      getOrderHistory(context)
    ]).then((List responses) {
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print('Error occurred: $e');
      Utils.showSnackBar("Something went wrong", context);
    });
  }

//start get user profile data........
  UserProfileModel? userProfileData;

  Future<bool> getUserProfileData(BuildContext context,
      {bool? shouldNotify}) async {
    var response = await ApiClient()
        .get('profile', header: Utils().apiHeader)
        .catchError((e) {
          print(e.message);
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return false;
    print(response);
    userProfileData = userProfileModelFromJson(response);
    if (shouldNotify == null) {
      isLoading = false;
      notifyListeners();
    }

    return true;
  }

//end get user profile data........
//start post user profile update........

  Future updateUserProfile(
    BuildContext context,
    String fName,
    String lName,
    String email,
    String phone,
  ) async {
    var uri = Uri.parse("${baseUrl}profile");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers.addAll(Utils().apiHeader);
      if (imagePath.isNotEmpty) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', imagePath);
        request.files.add(multipartFile);
      }

      Map<String, String> _fields = Map();
      _fields.addAll(<String, String>{
        "first_name": fName,
        "last_name": lName,
        "email": email,
        "phone": phone,
        '_method': 'PUT',
      });
      request.fields.addAll(_fields);
      http.StreamedResponse response = await request.send();
      var res = await http.Response.fromStream(response);
      print(res.statusCode);
      print(res.body);
      Utils.showSnackBar(jsonDecode(res.body)['message'], context);
      await getUserProfileData(context);
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    } catch (e) {
      Utils.showSnackBar(e.toString(), context);
      print(e);
    }
  }

//end post user profile update........

  /// get order history
  Future<void> getOrderHistory(BuildContext context) async {
    var response = await ApiClient()
        .get('order-history', header: Utils().apiHeader)
        .catchError((e) {
          print('--------');
          print(e.message);
          print('--------');
          Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;
    print(response);
    orderHistory = orderHistoryModelFromJson(response);
    return;
  }

  Future<bool> getOrderHisDetails(
      BuildContext context, String invoiceNo) async {
    // Utils().showLoadingIndicator(context);
    var response = await ApiClient()
        .get('order-history/$invoiceNo', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return false;
    print(response);
    orderHisModel = orderHistoryDetailsModelFromJson(response);
    //Utils.hideLoading(context);
    return true;
  }

  Future<bool> getReservationUserData(BuildContext context) async {
    var response = await ApiClient()
        .get('reservation', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
      print('errrorrr');
    });
    print(response);
    print("************************************99999999");

    if (response == null) return false;

    reservationUserData = reservationUserDataFromJson(response);

    print('done');
    return true;
  }
}
