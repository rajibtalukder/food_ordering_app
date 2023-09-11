import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:klio/view_model/profile_controller.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_controller.dart';
import '../home/table_reservation.dart';
import '../home/widgets/confirm_reservation.dart';

PreferredSizeWidget customAppBar(BuildContext context, {bool? isHome, bool? menuBtnOff}) {
  var pro = Provider.of<HomeController>(context, listen: false);
  var profilePro = Provider.of<ProfileController>(context, listen: false);
  return PreferredSize(
    preferredSize: Size.fromHeight(92.h),
    child: Container(
      height: 92.h,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(16.w, 24.h, 10.w, 0),
      child: Row(
        children: [
          Selector<HomeController, Object>(
            selector: (context, provider) => provider.isLoading,
            builder: (context, value, child) {
              return Row(
                children: [
                  titleText(
                      pro.generalSetting == null
                          ? "Klio"
                          : pro.generalSetting!.appName,
                      color: Color(0xff4D4D4D),
                      size: 30,
                      fontWeight: FontWeight.w700),
                  titleText(".",
                      color: primaryColor,
                      size: 30,
                      fontWeight: FontWeight.w700),
                ],
              );
            },
          ),
          const Spacer(),
          if (isHome != null)
            IconButton(
              onPressed: () {
                if (profilePro.userProfileData == null)
                  profilePro.getUserProfileData(context);
                tableReservation(context).then(
                  (value) {
                    pro.dateDropDownValue = 'Pick Date';
                    pro.timeDropDownValue = '';
                    pro.reservationTime = null;
                    for (int i = 0; i < pro.showInvalidSign.length; i++)
                      pro.showInvalidSign[i] = false;
                    if (pro.reservation != null)
                      confirmReservation(context)
                          .then((value) => pro.reservation = null);
                  },
                );
              },
              /*icon: const Icon(
                Icons.table_bar_outlined,
                color: secondaryDarkTextColor,
              ),*/
              icon: SizedBox(
                width: 30.w,
                child: Image.asset("assets/Table.png"),
              ),
            ),
          menuBtnOff==true?SizedBox(): AnimatedIconButton(),
        ],
      ),
    ),
  );
}

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({Key? key}) : super(key: key);

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<HomeController>(context, listen: false);
    return Selector<HomeController, Object>(
      selector: (context, provider) => provider.isDrawerOpen,
      builder: (context, value, child) {
        if (!pro.isDrawerOpen) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
        return IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            color: pro.isDrawerOpen ? primaryColor : primaryTextColor,
            size: 27.sp,
            progress: _animation,
          ),
          onPressed: () {
            if (pro.homeScaffoldKey.currentState != null) {
              pro.homeScaffoldKey.currentState?.openDrawer();
            }
            if (pro.signUpScaffoldKey.currentState != null) {
              pro.signUpScaffoldKey.currentState?.openDrawer();
            }
            if (pro.logInScaffoldKey.currentState != null) {
              pro.logInScaffoldKey.currentState?.openDrawer();
            }
          },
        );
      },
    );
  }
}
