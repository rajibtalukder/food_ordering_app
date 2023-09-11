import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view_model/favourite_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/colors.dart';
import '../../../view_model/home_controller.dart';
import '../../global_widgets/texts.dart';
import '../bottom_sheet.dart';
import 'allergies.dart';

SliverToBoxAdapter popularItems(BuildContext context) {
  var pro = Provider.of<HomeController>(context, listen: false);
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: pro.isLoading
          ? _loadingPopularItem(context)
          : swiperItem(pro, context),
    ),
  );
}

Widget swiperItem(HomeController pro, BuildContext context) {
  var favPro = Provider.of<FavouriteController>(context, listen: false);
  return SizedBox(
    height: 260.h,
    child: Swiper(
      itemBuilder: (context, index) {
        var data = pro.popularItem!.data[index];
        return GestureDetector(
          onTap: () {
            print("--------------------------------------------");

            // Provider.of<CartController>(context, listen: false).makePaypalPayment(context);
            //Provider.of<CartController>(context, listen: false).makePayment(5.99);
            pro.getMenuDetails(context, data.slug);
            bottomSheet(context, data.slug);
            // pro.getMenuDetails(context, "tea-green"/*data.slug*/);
            // bottomSheet(context, "tea-green"/*data.slug*/);
          },
          child: Stack(
            children: [
              SizedBox(
                height: 260.h,
                width: 200.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: Image.network(
                    data.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, __) => Container(
                      color: Colors.grey,
                      height: 250.h,
                      width: 200.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 0.w) * 0.48,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      titleText(data.name,
                          size: fontSmall,
                          fontWeight: FontWeight.w700,
                          usePrimaryFont: true,
                          color: Colors.white),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleText(
                            "${pro.generalSetting == null ? "£" : pro.generalSetting!.currencySymbol}${data.price}",
                            size: fontSmall,
                            color: primaryColor,
                            usePrimaryFont: true,
                          ),
                          allergiesList(
                            [
                              for (int i = 0;
                                  i < data.allergies.data.length;
                                  i++)
                                data.allergies.data[i].image
                            ],
                          ),
                          // Selector<HomeViewModel, Object>(
                          //   selector: (context, provider) => provider.isChange,
                          //   builder: (context, value, child) {
                          //   bool isCrt = pro.isCart(data.slug);
                          //   return Container(
                          //     height: 23.h,
                          //     width: 23.h,
                          //     padding: EdgeInsets.all(4.sp),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(4.sp),
                          //       color: primaryColor.withOpacity(0.2),
                          //     ),
                          //     child: GestureDetector(
                          //       onTap: (){
                          //         isCrt
                          //             ? pro.removeCartItems(data.slug, context)
                          //             : pro.addCartItems(data.slug,context);
                          //       },
                          //       child: Image.asset(
                          //         "assets/addToCart.png",
                          //         fit: BoxFit.cover,
                          //         color: primaryColor,
                          //       ),
                          //     ),
                          //   );
                          //   }
                          // )
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.h,
                child: Selector<FavouriteController, Object>(
                  selector: (context, provider) => provider.isFavChange,
                  builder: (context, value, child) {
                    bool isFav = favPro.isFavourite(data.slug);
                    return Container(
                      height: 35.h,
                      width: 35.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_outline,
                            color: primaryColor,
                            size: 18.sp,
                          ),
                          onPressed: () {
                            isFav
                                ? favPro.removeFavouriteItems(data.slug)
                                : favPro.addFavouriteItems(data.slug);
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
      itemCount: pro.popularItem == null ? 0 : pro.popularItem!.data.length,
      viewportFraction: 0.48,
      scale: 0.8,
    ),
  );
}

Widget _loadingPopularItem(BuildContext context) {
  return SizedBox(
    height: 280.h,
    child: Swiper(
      itemCount: 5,
      viewportFraction: 0.48,
      scale: 0.8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 260.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: secondaryTextColor.withOpacity(0.4),
            ),
          ),
        );
      },
    ),
  );
}
