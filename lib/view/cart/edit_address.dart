import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/model/user_address_model.dart';
import 'package:klio/view/global_widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts_constants.dart';
import '../../view_model/cart_controller.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);
  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController searchController = TextEditingController();

  late CartController pro;

  @override
  void initState() {
    pro = Provider.of<CartController>(context, listen: false);
    super.initState();
  }

  String? selectedValue;
  List<String> addressType = ['Home', 'Office', 'Market', 'Others'];
  String apiKey = "AIzaSyCqRhnrGLiphmBXcO06e_xDsafRPOfi5m8";

  @override
  Widget build(BuildContext context) {
    var temp = ModalRoute.of(context)!.settings.arguments;
    int? id;
    UserAddress? data;
    if (temp != null) {
      id = temp as int;
      data = pro.userAddress?[id];
      addressCtlr = TextEditingController(text: pro.singleAddress?.location);
      selectedValue = pro.singleAddress?.type;
    }
    // selectedValue = pro.singleAdrress?.type;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: const BackButton(color: primaryTextColor),
        title:  Text(temp==null?'Add New Address': 'Edit Address',
            style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
              child: DropdownButton<String>(
                iconEnabledColor: primaryTextColor,
                value: selectedValue,
                items: addressType.map((dynamic val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(val,
                          style: TextStyle(
                              color: primaryTextColor,
                              fontSize: fontVerySmall)),
                    ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(10),
                underline: const SizedBox(),
                disabledHint: const Text('Disable'),
                dropdownColor: white,
                elevation: 1,
                hint: Text(selectedValue ?? 'Choose address type',
                    style: const TextStyle(color: Colors.black)),
                style:
                    TextStyle(color: primaryTextColor, fontSize: fontVerySmall),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            /// orderTextField(addressCtlr, 'Delivery Address', 10,
            ///     iconName: 'location.png'),

            GooglePlaceAutoCompleteTextField(
              textEditingController: addressCtlr,
              boxDecoration: BoxDecoration(),
              googleAPIKey: apiKey,
              inputDecoration: InputDecoration(),
              debounceTime: 800,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                print("placeDetails" + prediction.lng.toString());
              },
              itemClick: (Prediction prediction) {
                addressCtlr.text = prediction.description!;
                addressCtlr.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length));
              },
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(child: Text("${prediction.description ?? ""}"))
                    ],
                  ),
                );
              },
              seperatedBuilder: Divider(),
              isCrossBtnShown: true,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
                onTap: () {
                  pro.singleAddress == null
                      ? pro.updateUserAddress(context, selectedValue.toString(),
                          addressCtlr.text, false)
                      : pro.updateUserAddress(
                          context,
                          selectedValue == null
                              ? data!.type
                              : selectedValue.toString(),
                          addressCtlr.text,
                          true,
                          id: id.toString());
                  Navigator.of(context).pop();
                },
                child: customButton(text: 'Submit')),
          ],
        ),
      ),
    );
  }
}
