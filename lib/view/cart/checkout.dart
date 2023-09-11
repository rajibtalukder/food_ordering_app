import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/utils/utils.dart';
import 'package:klio/view/cart/widgets/build_address.dart';
import 'package:klio/view/cart/widgets/orderStage.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/fonts_constants.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/texts.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isPick = false;
  bool isDelivery = true;
  String selectedValue = '';
  List deliveryType = ['Pick-Up', 'Delivery'];

  late CartController pro;

  @override
  void initState() {
    pro = Provider.of<CartController>(context, listen: false);
    pro.getUserAddress(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pro.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    //var pro = Provider.of<CartController>(context, listen: false);
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: (840 - padding.top - padding.bottom).h,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: fontSmall),
                        titleText('Your Order',
                            size: fontSmall, usePrimaryFont: true)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                orderStage('Checkout', primaryColor, white),
                SizedBox(height: 30.h),
                // titleText('Login Account', size: fontSmall),
                // SizedBox(height: 10.h),
                // loginAcInfo(),
                titleText('Choose Address', size: fontBig),
                SizedBox(height: 10.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Selector<CartController, Object>(
                      selector: (context, provider) => provider.isLoading,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            if (pro.isLoading) _loadingAddress(context),
                            if (!pro.isLoading)
                              for (int i = 0; i < pro.userAddress!.length; i++)
                                buildAddress(context, pro, i),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('EditAddress');
                    pro.singleAddress = null;
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                    height: 45.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.sp),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: Center(
                      child: Text(
                        'Add New Address',
                        style: TextStyle(
                          fontSize: fontSmall,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: secondaryTextColor.withOpacity(0.18),
                  thickness: 1,
                ),

                Row(
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value: isPick,
                      onChanged: (bool? value) {
                        setState(() {
                          isPick = value!;
                          selectedValue = deliveryType[0].toString();
                          if (isPick) {
                            pro.selectAddress = -1;
                          }
                          if (isDelivery) {
                            isDelivery = false;
                            selectedValue = deliveryType[0].toString();
                          }
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPick = !isPick;
                          selectedValue = deliveryType[0].toString();
                          if (isPick) {
                            pro.selectAddress = -1;
                          }
                          if (isDelivery) {
                            isDelivery = false;
                            selectedValue = deliveryType[0].toString();
                          }
                        });
                      },
                      child: titleText('Pick-Up',
                          size: fontVerySmall, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 60.w),
                    Checkbox(
                      activeColor: primaryColor,
                      value: isDelivery,
                      onChanged: (bool? value) {
                        setState(() {
                          isDelivery = value!;
                          selectedValue = deliveryType[1].toString();
                          if (isDelivery) {
                            pro.selectAddress = 0;
                          }
                          if (isPick) {
                            isPick = false;
                          }
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDelivery = !isDelivery;
                          selectedValue = deliveryType[1].toString();
                          if (isDelivery) {
                            pro.selectAddress = 0;
                          }
                          if (isPick) {
                            isPick = false;
                          }
                        });
                      },
                      child: titleText('Delivery',
                          size: fontVerySmall, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),

                Divider(
                  color: secondaryTextColor.withOpacity(0.18),
                  thickness: 1,
                ),
                titleText('Payment Method', size: fontBig),
                Selector<CartController, Object>(
                  selector: (context, provider) =>
                      provider.showOnlinePaymentOption,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildRadioButton(
                                SingingCharacter.cash, "Cash On Delivery"),
                            buildRadioButton(
                                SingingCharacter.online, "Online Payment"),
                          ],
                        ),
                        if (pro.showOnlinePaymentOption)
                          Selector<CartController, Object>(
                            selector: (context, provider) =>
                                provider.selectedPaymentWay,
                            builder: (context, value, child) {
                              return Row(
                                children: [
                                  buildPaymentOption("Paypal", "paypal", 1),
                                  SizedBox(width: 10.w),
                                  buildPaymentOption("Stripe", "stripe", 2),
                                ],
                              );
                            },
                          )
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    if (!isPick && !isDelivery) {
                      Utils.showSnackBar(
                          "Please select a delivery method", context);
                      return;
                    }
                    pro.addOrder(
                      context,
                      isPick ? "pickup" : "delivery",
                      pro.showOnlinePaymentOption
                          ? pro.selectedPaymentWay == 1
                              ? "Paypal"
                              : "Stripe"
                          : "Cash",
                    );
                  },
                  child: customButton(
                      text: 'Place Order',
                      imageName: 'forwardArrow.png',
                      height: 45.h),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPaymentOption(String text, String image, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          pro.changePaymentWay(index);
        },
        child: Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  color: pro.selectedPaymentWay == index
                      ? Colors.black.withOpacity(0.1)
                      : borderColor,
                  width: pro.selectedPaymentWay == index ? 2 : 1),
              color: pro.selectedPaymentWay == index
                  ? primaryColor.withOpacity(0.3)
                  : white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h, child: Image.asset("assets/$image.png")),
              SizedBox(width: 15.w),
              titleText(text, size: fontSmall, fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildRadioButton(SingingCharacter value, String text) {
    return SizedBox(
      width: 170.w,
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            pro.changePaymentMethod(pro.showOnlinePaymentOption
                ? value == SingingCharacter.online ? value : SingingCharacter.cash
                :  value == SingingCharacter.cash ? value : SingingCharacter.online);
          },
          child:
              titleText(text, size: fontVerySmall, fontWeight: FontWeight.w700),
        ),
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        leading: Radio<SingingCharacter>(
          activeColor: primaryColor,
          value: value,
          groupValue: pro.paymentMethod,
          onChanged: (SingingCharacter? value) {
            if (value != null) pro.changePaymentMethod(value);
          },
        ),
      ),
    );
  }

  Shimmer _loadingAddress(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: EdgeInsets.all(5.h),
        height: 70.h,
        width: 400.w,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: secondaryTextColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
