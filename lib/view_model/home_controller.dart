import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:klio/model/general_setting.dart';
import 'package:klio/model/menu_details_model.dart';
import '../model/menu_items_model.dart';
import '../model/reservation_model.dart';
import '../model/reservation_time_model.dart';
import '../service/api_client.dart';
import '../utils/utils.dart';
import 'package:klio/model/popular_items_model.dart';

class HomeController with ChangeNotifier {
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey();
  final GlobalKey<ScaffoldState> logInScaffoldKey = GlobalKey();
  final GlobalKey<ScaffoldState> signUpScaffoldKey = GlobalKey();

  TextEditingController searchController = TextEditingController();

  PopularItemsModel? popularItem;
  MenuItemModel? menuItem;
  List<ReservationTimeModel>? reservationTime;
  ReservationModel? reservation;

  // I am using the link as a object structure, just to avoid creating a new model.
  // creating a filters item so that while searching filters will not change
  List<Link>? filterItems = [];

  MenuDetailsModel? menuDetails;
  GeneralSettingModel? generalSetting;

  String selectedFilter = "Popular";
  bool isDrawerOpen = false;
  bool isLoading = true;
  bool isMenuDetailsLoading = false;
  double scrolledPixel = 0;

  String dateDropDownValue = "Pick Date";
  String timeDropDownValue = "";

  List<bool> showInvalidSign = [false, false, false];

  changeValiditySign(int index, bool value) {
    showInvalidSign[index] = value;
    notifyListeners();
  }

  changeDateDropDownValue(String value) {
    dateDropDownValue = value;
    notifyListeners();
  }

  changeTimeDropDownValue(String value) {
    timeDropDownValue = value;
    notifyListeners();
  }

  _changeLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }

  changeDrawerState(bool state) {
    isDrawerOpen = state;
    notifyListeners();
  }

  changeSelectedFilter(String name) {
    selectedFilter = name;
    notifyListeners();
  }

  changeScrollPixel(double value) {
    scrolledPixel = value;
    notifyListeners();
  }

  getHomeData(BuildContext context) {
    Future.wait([
      _getPopularItems(context),
      _getMenuItems(context),
      _getGeneralSetting(context)
    ]).then((List responses) => _changeLoadingState(false)).catchError((e) {
      Utils.showSnackBar("Something went wrong", context);
    });
  }

  Future<void> _getPopularItems(BuildContext context) async {
    var response = await ApiClient()
        .get('popular-item', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;

    popularItem = popularItemsModelFromJson(response);

    return;
  }

  Future<void> _getMenuItems(BuildContext context) async {
    var response = await ApiClient()
        .get('menu', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;
    menuItem = menuItemModelFromJson(response);
    for (var element in menuItem!.data) {
      filterItems
          ?.add(Link(label: element.name, active: false, url: element.image));
    }
  }

  Future<void> _getGeneralSetting(BuildContext context) async {
    var response = await ApiClient()
        .get('general-setting', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;

    generalSetting = generalSettingModelFromJson(response);

    return;
  }

  Future<void> searchItems(BuildContext context, String text) async {
    _changeLoadingState(true);
    var response = await ApiClient()
        .get('menu?keyword=$text&category=$selectedFilter',
            header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;
    if (json.decode(response)["data"].isEmpty) {
      menuItem?.data = [];
      _changeLoadingState(false);
      return;
    }

    menuItem = menuItemModelFromJson(response);
    _changeLoadingState(false);
  }

  Future getMenuDetails(BuildContext context, String id) async {
    isMenuDetailsLoading = true;
    notifyListeners();
    var response = await ApiClient()
        .get('menu/$id', header: Utils().apiHeader)
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });
    if (response == null) return;
    menuDetails = menuDetailsModelFromJson(response);
    isMenuDetailsLoading = false;
    notifyListeners();
    return;
  }

  /// Reservation ------------------------------------------------

  Future<void> getAvailableSlot(BuildContext context, String person) async {
    Utils().showLoadingIndicator(context);
    var body = {"total_person": person, "expected_date": dateDropDownValue};
    print(body);
    var response = await ApiClient()
        .post('reservation/checking',
            payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.hideLoading(context);
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    if (response == null) return;
    reservationTime = reservationTimeModelFromJson(response);
    if (reservationTime != null)
      for (var element in reservationTime!) {
        if (element.available) {
          timeDropDownValue = element.time;
          notifyListeners();
          break;
        }
      }

    return;
  }

  Future<void> reserveTable(
      BuildContext context, String person, String number, String id) async {
    Utils().showLoadingIndicator(context);
    var body = {
      "user_id" : id,
      "total_person": person,
      "expected_date": dateDropDownValue,
      "expected_time": timeDropDownValue,
      "contact_no": number
    };
    print(body);
    print('-------');
    var response = await ApiClient()
        .post('reservation', payloadObj: body, header: Utils().apiHeader)
        .catchError((e) {
      Utils.hideLoading(context);
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    if (response == null) return;
    print('-------5');
    reservation = reservationModelFromJson(response);
    print('-------6');
    return;
  }

  Future<void> confirmReservation(
      BuildContext context, String name, String email,
      {String? occasion, String? spacialRequest}) async {
    Utils().showLoadingIndicator(context);
    var body = {
      "name": name,
      "email": email,
      if (occasion != null) "occasion": occasion,
      if (spacialRequest != null) "special_request": spacialRequest
    };

    var response = await ApiClient()
        .put('reservation/${reservation!.data.invoice}', body)
        .catchError((e) {
      Utils.hideLoading(context);
      Utils.showSnackBar(e.message, context);
    });
    Utils.hideLoading(context);
    if (response == null) return;
    Utils.showSnackBar(json.decode(response)['message'], context,
        color: Colors.green);
    return;
  }
}
