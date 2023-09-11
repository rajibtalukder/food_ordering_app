import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/home/widgets/category_list.dart';
import 'package:klio/view/home/widgets/filter.dart';
import 'package:klio/view/home/widgets/popular_items.dart';
import 'package:klio/view/home/widgets/search.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:klio/view_model/favourite_controller.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../view_model/profile_controller.dart';
import '../global_widgets/custom_app_bar.dart';
import '../global_widgets/drawer.dart';
import '../global_widgets/texts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double size = 0;

  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false).getHomeData(context);
    Provider.of<CartController>(context, listen: false).getCartItems();
    Provider.of<FavouriteController>(context, listen: false)
        .getFavouriteItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      key: pro.homeScaffoldKey,
      drawer: sideDrawer(true, context),
      onDrawerChanged: (value) {
        pro.changeDrawerState(value);
        if(pro.isDrawerOpen){
          var profilePro = Provider.of<ProfileController>(context, listen: false);
          profilePro.getUserProfileData(context);
          print(profilePro.userProfileData);
        }
      },
      appBar: customAppBar(context, isHome: true),
      body: Selector<HomeController, Object>(
        selector: (context, provider) => provider.isLoading,
        builder: (context, value, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.depth == 1) return true;
              size = scrollNotification.metrics.pixels;
              if (size > 45) size = 52;
              if (size < 7) size = 0;
              if (size != pro.scrolledPixel) {
                pro.changeScrollPixel(size);
              }
              return true;
            },
            child: _buildMainBody(pro),
          );
        },
      ),
    );
  }

  Selector<HomeController, Object> _buildMainBody(HomeController pro) {
    return Selector<HomeController, Object>(
      selector: (context, provider) => provider.selectedFilter,
      builder: (context, value, child) {
        return Column(
          children: [
            search( pro),
            filter(pro),
            const SizedBox(height: 15),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (pro.selectedFilter == "Popular" && pro.searchController.text.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: titleText("Popular Items",usePrimaryFont: true),
                      ),
                    ),
                  if (pro.selectedFilter == "Popular" && pro.searchController.text.isEmpty) buildSpace(16),
                  if (pro.selectedFilter == "Popular" && pro.searchController.text.isEmpty) popularItems(context),
                  if (pro.selectedFilter == "Popular" && pro.searchController.text.isEmpty) buildSpace(16),
                  buildSpace(6),
                  if (pro.isLoading) _loadingCategory(context),
                  if (!pro.isLoading)
                    for (int i = 0; i < pro.menuItem!.data.length; i++) ...[
                      if (pro.selectedFilter == pro.menuItem!.data[i].name ||
                          pro.selectedFilter == "Popular")
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(thickness: 6,color: borderColor.withOpacity(0.4)),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: titleText(pro.menuItem!.data[i].name),
                              ),
                            ],
                          ),
                        ),
                      if (pro.selectedFilter == pro.menuItem!.data[i].name ||
                          pro.selectedFilter == "Popular")
                        categoryList(context, i),
                      // if (pro.selectedFilter == pro.menuItem!.data[i].name ||
                      //     pro.selectedFilter == "Popular")
                      //   buildSpace(25),
                    ],
                  buildSpace(70.h),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

SliverToBoxAdapter buildSpace(double size) =>
    SliverToBoxAdapter(child: SizedBox(height: size.h));

SliverList _loadingCategory(BuildContext context) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
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
      },
      childCount: 5,
    ),
  );
}
