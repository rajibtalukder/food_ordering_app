import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/profile/profile.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:klio/view_model/favourite_controller.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../view_model/home_controller.dart';
import 'cart/cart.dart';
import 'favourite/favourite.dart';
import 'home/home.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _bottomNavIndex = 0;

  List<IconData> iconsTemp = [
    Icons.home_outlined,
    Icons.shopping_cart_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
  ];

  List<IconData> icons = [];

  List<Widget> pages = [
    const Home(),
    const Cart(),
    const Favourite(),
    const Profile(),
  ];

  @override
  void initState() {
    _changeIcon();
    icons[_bottomNavIndex] = Icons.home_rounded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: pages[_bottomNavIndex],
      bottomNavigationBar: Stack(
        children: [
          AnimatedBottomNavigationBar(
            shadow: BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, -15),
                blurRadius: 10),
            icons: icons,

            notchSmoothness: NotchSmoothness.softEdge,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.none,
            iconSize: 24.sp,

            inactiveColor: Colors.grey,
            activeColor: primaryColor,
            leftCornerRadius: 20.sp,
            rightCornerRadius: 20.sp,
            onTap: (index) => setState(
              () {
                _bottomNavIndex = index;
                if (_bottomNavIndex == 0) {
                  _changeIcon();
                  icons[_bottomNavIndex] = Icons.home_rounded;
                }
                Provider.of<HomeController>(context, listen: false)
                    .changeDrawerState(false);
                if (_bottomNavIndex == 1) {
                  _changeIcon();
                  icons[_bottomNavIndex] = Icons.shopping_cart;
                }
                if (_bottomNavIndex == 2) {
                  _changeIcon();
                  icons[_bottomNavIndex] = Icons.favorite;
                }
                ;
                if (_bottomNavIndex == 3) {
                  _changeIcon();
                  icons[_bottomNavIndex] = Icons.person;
                }
              },
            ),
            //other params
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < icons.length; i++)
                IgnorePointer(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 10.w, 0, 0),
                    child: _buildCircleAvatar(i, context),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCircleAvatar(int i, BuildContext context) {
    return Consumer<CartController>(
      builder: (context, provider, child) {
        return Consumer<FavouriteController>(
          builder: (context, provider, child) {
            int cartLength = Provider.of<CartController>(context, listen: false)
                .localCartItems
                .length;

            int favLength =
                Provider.of<FavouriteController>(context, listen: false)
                    .favouriteItemTds
                    .length;
            return CircleAvatar(
              backgroundColor: i == 0 || i == 3
                  ? Colors.transparent
                  : i == 1
                      ? cartLength == 0
                          ? Colors.transparent
                          : _bottomNavIndex == i
                              ? primaryColor.withOpacity(0.2)
                              : primaryColor
                      : favLength == 0
                          ? Colors.transparent
                          : _bottomNavIndex == i
                              ? primaryColor.withOpacity(0.2)
                              : primaryColor,
              radius: 10.r,
              child: Text(
                i == 1 ? cartLength.toString() : favLength.toString(),
                style: TextStyle(
                  color: i == 0 || i == 3
                      ? Colors.transparent
                      : i == 1
                          ? cartLength == 0
                              ? Colors.transparent
                              : Colors.white
                          : favLength == 0
                              ? Colors.transparent
                              : Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            );
          },
        );
      },
    );
  }

  _changeIcon() {
    icons.clear();
    for (var element in iconsTemp) {
      icons.add(element);
    }
  }
}
