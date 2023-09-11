import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/model/cart_items_model.dart';
import 'package:klio/view/home/widgets/bottom_sheet_widgets.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../view_model/home_controller.dart';
import '../global_widgets/texts.dart';

bottomSheet(BuildContext context, String slug, {CartItemsModel? item}) {
  var homeProvider = Provider.of<HomeController>(context, listen: false);

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Selector<HomeController, Object>(
        selector: (context, provider) => provider.isMenuDetailsLoading,
        builder: (context, value, child) {
          return homeProvider.isMenuDetailsLoading ||
                  homeProvider.menuDetails == null
              ? _loadingMenuDetails(context)
              : buildBody(context, homeProvider, slug, item: item);
        },
      );
    },
  );
}

Container buildBody(
    BuildContext context, HomeController homeProvider, String slug,
    {CartItemsModel? item}) {
  var data = homeProvider.menuDetails!.data;
  var cartProvider = Provider.of<CartController>(context, listen: false);

  cartProvider.cartItem = item ??
      CartItemsModel(
        data: Data(
          slug: data.slug,
          quantity: 1,
          selectedVariants:
              data.variants.data.isNotEmpty ? data.variants.data[0].name : "",
          selectedVariantsId:
              data.variants.data.isNotEmpty ? data.variants.data[0].id : 0,
          addons: Addons(data: [
            for (int i = 0; i < data.addons.data.length; i++)
              Datum(id: data.addons.data[i].id, quantity: 0)
          ]),
        ),
      );

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.sp),
        topRight: Radius.circular(30.sp),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: [
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Image.network(
                  data.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) =>
                      Image.asset("assets/no_image.jpg"),
                ),
              ),
            ),
            Positioned(
              right: 16.w,
              top: 16.h,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17.r,
                  child: const Icon(
                    Icons.close_outlined,
                    color: primaryTextColor,
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText(data.name,
                      size: fontSmall,
                      fontWeight: FontWeight.w700,
                      usePrimaryFont: true),
                  SizedBox(
                    width: 155.w,
                    child: subTitleText(data.description, usePrimaryFont: true),
                  ),
                ],
              ),
              Selector<CartController, Object>(
                selector: (context, provider) =>
                    provider.cartItem!.data.selectedVariants,
                builder: (context, value, child) {
                  return titleText(
                    "${homeProvider.generalSetting == null ? "£" : homeProvider.generalSetting!.currencySymbol}${data.variants.data.firstWhere((element) => element.id == cartProvider.cartItem?.data.selectedVariantsId).price}",
                    size: fontSmall,
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  );
                },
              ),
            ],
          ),
        ),
        if (homeProvider.menuDetails!.data.addons.data.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 10.h),
              child: titleText("Select addons:",
                  size: fontSmall, fontWeight: FontWeight.bold),
            ),
          ),
        buildAddons(homeProvider, cartProvider),
        buildVariants(homeProvider, cartProvider),
        buildCartButton(slug, cartProvider, item != null, context),
        SizedBox(height: 20.h)
      ],
    ),
  );
}

Widget _loadingMenuDetails(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Container(
      height: 450.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.sp),
          topRight: Radius.circular(30.sp),
        ),
      ),
    ),
  );
}
