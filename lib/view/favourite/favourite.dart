import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view/favourite/widgets/favourite_item.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/favourite_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  late FavouriteController pro;

  @override
  void initState() {
    pro = Provider.of<FavouriteController>(context, listen: false);
    pro.isLoading = true;
    pro.getFavItemsById(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> numberWidgets = [];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite',
              style: TextStyle(color: primaryTextColor)),
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
        ),
        body: Selector<FavouriteController, Object>(
            selector: (context, provider) => provider.isLoading,
            builder: (context, value, child) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (pro.isLoading)
                      for (int i = 0; i < pro.favouriteItemTds.length; i++)
                        _loadingCartItem(context),
                    if (!pro.isLoading && pro.favItemList != null)
                      Selector<FavouriteController, Object>(
                        selector: (context, provider) => provider.isFavChange,
                        builder: (context, value, child) {
                          numberWidgets.clear();
                          for (int i = 0;
                              i < pro.favItemList!.data.length;
                              i++) {
                            numberWidgets.add(favouriteItem(i, pro, context));
                          }
                          return Column(children: numberWidgets);
                        },
                      ),
                    Selector<FavouriteController, Object>(
                      selector: (context, provider) => provider.isFavChange,
                      builder: (context, value, child) {
                        return pro.favouriteItemTds.isNotEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(top: 300.h),
                                child: Center(
                                  child: titleText('No Item Added',
                                      color: primaryTextColor,
                                      size: fontBig,
                                      fontWeight: FontWeight.normal),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              );
            }));
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
