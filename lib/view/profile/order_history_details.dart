import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view/profile/widgets/text_row.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../view_model/profile_controller.dart';

class OrderHistoryDetails extends StatelessWidget {
  const OrderHistoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: const BackButton(color: primaryTextColor),
        elevation: 0.0,
        title: const Text('Order History Details',
            style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textRow('Invoice', pro.orderHisModel?.data.invoice ?? ""),
              textRow('Status', pro.orderHisModel?.data.status ?? ""),
              textRow('Processing Time',
                  pro.orderHisModel?.data.processingTime ?? ""),
              // textRow('Available Time',
              //     pro.orderHisModel?.data.availableTime ?? ""),
              textRow('Discount', pro.orderHisModel?.data.discount ?? ""),
              textRow(
                  'Reward Amount', pro.orderHisModel?.data.rewardsAmount ?? ""),
              textRow('Service Charge',
                  pro.orderHisModel?.data.serviceCharge ?? ""),
              textRow(
                  'Delivery type', pro.orderHisModel?.data.deliveryType ?? ""),
              textRow('Delivery Charge',
                  pro.orderHisModel?.data.deliveryCharge ?? ""),
              textRow('Grand Total', pro.orderHisModel?.data.grandTotal ?? ""),
              textRow('Note', pro.orderHisModel?.data.note ?? ""),
              textRow('Reward Point',
                  pro.orderHisModel?.data.rewards.toString() ?? ""),
              textRow('Date Time', pro.orderHisModel?.data.dateTime ?? ""),
              titleText('Address :',
                  color: primaryTextColor, size: fontSmall),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    DataTable(
                      border: TableBorder(
                          bottom: BorderSide(color: borderColor, width: 1),
                          left: BorderSide(color: borderColor, width: 1),
                          top: BorderSide(color: borderColor, width: 1),
                          right: BorderSide(color: borderColor, width: 1),
                          horizontalInside:
                          BorderSide(color: borderColor, width: 1),
                          verticalInside:
                          BorderSide(color: borderColor, width: 1)),
                      columns: [
                        DataColumn(
                            label: titleText('Type',
                                color: primaryTextColor, size: fontSmall)),
                        DataColumn(
                            label: titleText('Location',
                                color: primaryTextColor, size: fontSmall)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(titleText(
                              '${pro.orderHisModel?.data.address.type}',
                              color: primaryColor,
                              size: fontSmall)),
                          DataCell(titleText(
                              '${pro.orderHisModel?.data.address.location}',
                              color: primaryColor,
                              size: fontSmall)),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText('Order Details :', size: fontBig),
                  for (int i = 0;
                      i < pro.orderHisModel!.data.orderDetails.data.length;
                      i++)
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 10),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      //height: 300.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            textRow(
                                'Menu',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .menu ??
                                    ''),
                            textRow(
                                'Variant',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .variant ??
                                    ''),
                            // textRow(
                            //     'Processing Time',
                            //     pro.orderHisModel?.data.orderDetails.data[i]
                            //             .processingTime ??
                            //         ''),
                            // textRow(
                            //     'Status',
                            //     pro.orderHisModel?.data.orderDetails.data[i]
                            //             .status ??
                            //         ''),
                            textRow(
                                'Price',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .price ??
                                    ''),
                            textRow(
                                'Quantity',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .quantity
                                        .toString() ??
                                    ''),
                            textRow(
                                'Vat',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .vat ??
                                    ''),
                            textRow(
                                'Total Price',
                                pro.orderHisModel?.data.orderDetails.data[i]
                                        .totalPrice ??
                                    ''),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     titleText('Addons', color: primaryTextColor, size: fontSmall),
                            //
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
