import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view/cart/widgets/orderItem.dart';
import 'package:klio/view/cart/widgets/orderStage.dart';
import 'package:klio/view/cart/widgets/orderTextField.dart';
import 'package:klio/view/cart/widgets/totalAmount.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/fonts_constants.dart';
import '../../view_model/profile_controller.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/texts.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartController pro;
  late ProfileController profilePro;

  @override
  void initState() {
    pro = Provider.of<CartController>(context, listen: false);
    profilePro = Provider.of<ProfileController>(context, listen: false);
    profilePro.getProfileData(context);
    pro.isLoading = true;
    pro.getCartItemsById(context);

    super.initState();
  }

  @override
  void dispose() {
    pro.useReward = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<Widget> numberWidgets = [];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Selector<CartController, Object>(
            selector: (context, provider) => provider.isLoading,
            builder: (context, value, child) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    orderStage('Your Order', white, primaryTextColor),
                    SizedBox(height: 20.h),
                    if (pro.isLoading)
                      for (int i = 0; i < pro.localCartItems.length; i++)
                        _loadingCartItem(context),
                    if (!pro.isLoading && pro.cartItemList != null)
                      Selector<CartController, Object>(
                        selector: (context, provider) => provider.isChange,
                        builder: (context, value, child) {
                          numberWidgets.clear();
                          for (int i = 0;
                              i < pro.cartItemList!.data.length;
                              i++) {
                            numberWidgets.add(orderItem(i, pro, context));
                          }
                          return Column(children: numberWidgets);
                        },
                      ),
                    SizedBox(height: 20.h),
                    Selector<CartController, Object>(
                      selector: (context, provider) => provider.useReward,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: Checkbox(
                                activeColor: primaryColor,
                                value: pro.useReward,
                                onChanged: (bool? value) {
                                  if (pro.isLoading) return;
                                  pro.changeReward(value ?? false);
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: () {
                                if (pro.isLoading) return;
                                pro.changeReward(!pro.useReward);
                              },
                              child: titleText('Use rewards',
                                  size: fontSmall, fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Selector<ProfileController, Object>(
                              selector: (context, provider) =>
                                  provider.isLoading,
                              builder: (context, value, child) {
                                return titleText(
                                    profilePro.userProfileData == null
                                        ? "0"
                                        : profilePro
                                            .userProfileData!.data.reward
                                            .toString(),
                                    size: fontSmall,
                                    fontWeight: FontWeight.w700);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text('Add more Items',
                        style: TextStyle(
                            fontSize: fontVerySmall, color: primaryTextColor)),
                    SizedBox(height: 10.h),
                    orderTextField(
                      controller,
                      'Voucher',
                      43,
                      iconName: 'voucher.png',
                      sufIconName: 'delete.png',
                      sufActivity: (String value) {
                        if (value.isEmpty) {
                          pro.deleteVoucher();
                          controller.clear();
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w, vertical: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Selector<CartController, Object>(
                              selector: (context, provider) =>
                                  provider.isVoucherChangeVoucher,
                              builder: (context, value, child) {
                                return Text(
                                    pro.voucherData == null
                                        ? ""
                                        : pro.voucherData!.message,
                                    style: TextStyle(
                                        fontSize: fontVerySmall,
                                        color: Colors.green));
                              }),
                          InkWell(
                            onTap: () {
                              if (controller.text.isEmpty) return;
                              pro.voucherData = null;
                              pro.getVoucher(context, controller.text);
                            },
                            child: Text(
                              'Apply Voucher',
                              style: TextStyle(
                                  fontSize: fontVerySmall, color: primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    pro.isLoading
                        ? _loadingTotal(context)
                        : totalAmountWidget(pro, context),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        if (pro.isLoading || pro.localCartItems.isEmpty) return;
                        pro.selectAddress = 0;
                        pro.isLoading = true;
                        Navigator.of(context).pushNamed('Checkout');
                      },
                      child: Selector<CartController, Object>(
                          selector: (context, provider) =>
                          provider.localCartItems.isEmpty,
                          builder: (context, value, child) {
                          return customButton(
                            text: 'Review Payment & Address',
                            color: pro.localCartItems.isEmpty
                                ? primaryColor.withOpacity(0.3)
                                : primaryColor);}
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Shimmer _loadingCartItem(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Container(
      width: double.infinity,
      height: 100.h,
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      decoration: BoxDecoration(
        color: secondaryTextColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

Shimmer _loadingTotal(BuildContext context) {
  var pro = Provider.of<HomeController>(context, listen: false);
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Column(
      children: [
        singleRow('Sub Total', '**', pro),
        singleRow('Delivery', '**', pro),
        singleRow('Discount', '**', pro),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            titleText('Total', size: fontMedium),
            titleText('£**', size: fontMedium, color: primaryColor)
          ],
        )
      ],
    ),
  );
}
