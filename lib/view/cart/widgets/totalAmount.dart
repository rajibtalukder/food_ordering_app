import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts_constants.dart';
import '../../../view_model/home_controller.dart';
import '../../../view_model/profile_controller.dart';
import '../../global_widgets/texts.dart';

Widget totalAmountWidget(CartController pro, BuildContext context) {
  var homePro = Provider.of<HomeController>(context, listen: false);
  var profilePro = Provider.of<ProfileController>(context, listen: false);
  double reward = 0.0;
  return Selector<CartController, Object>(
    selector: (context, provider) => provider.isVoucherChangeVoucher,
    builder: (context, value, child) {
      return Selector<CartController, Object>(
        selector: (context, provider) => provider.cartSubTotal,
        builder: (context, value, child) {
          pro.calculateDiscount();
          print("+++++++++++++++++++");
          return Column(
            children: [
              singleRow(
                  'Sub Total', pro.cartSubTotal.toStringAsFixed(2), homePro),
              singleRow(
                  'Delivery',
                  homePro.generalSetting == null
                      ? '0.00'
                      : homePro.generalSetting!.deliveryCharge,
                  homePro),
              singleRow('Vat', pro.cartVat.toStringAsFixed(2), homePro),
              singleRow('Discount', pro.discount.toStringAsFixed(2), homePro),
              Selector<CartController, Object>(
                selector: (context, provider) => provider.useReward,
                builder: (context, value, child) {
                  if (pro.useReward && profilePro.userProfileData != null)
                    reward = profilePro.userProfileData!.data.reward *
                        double.parse(
                            homePro.generalSetting!.rewardExchangeRate);
                  if (!pro.useReward) reward = 0;
                  return pro.useReward
                      ? singleRow('Reward', reward.toStringAsFixed(2), homePro)
                      : SizedBox();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText('Total', size: fontMedium),
                  titleText(
                      '${homePro.generalSetting == null ? "£" : homePro.generalSetting!.currencySymbol}${(pro.cartSubTotal - pro.discount + double.parse(homePro.generalSetting == null ? '0.00' : homePro.generalSetting!.deliveryCharge) - reward + pro.cartVat).toStringAsFixed(2)}',
                      size: fontMedium,
                      color: primaryColor)
                ],
              )
            ],
          );
        },
      );
    },
  );
}

Widget singleRow(String text, String amount, HomeController pro) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(text, style: TextStyle(fontSize: 12.sp)),
      titleText(
          '${pro.generalSetting == null ? "£" : pro.generalSetting!.currencySymbol}$amount',
          size: fontSmall)
    ],
  );
}
