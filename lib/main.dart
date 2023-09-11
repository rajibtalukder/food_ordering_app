import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klio/utils/shared_preferences.dart';
import 'package:klio/view/authentication/login.dart';
import 'package:klio/view/authentication/signup.dart';
import 'package:klio/view/authentication/verification.dart';
import 'package:klio/view/cart/checkout.dart';
import 'package:klio/view/cart/edit_address.dart';
import 'package:klio/view/custom_bottom_nev.dart';
import 'package:klio/view/home/terms_&_conditions.dart';
import 'package:klio/view/profile/edit_profile.dart';
import 'package:klio/view/profile/order_history_details.dart';
import 'package:klio/view/profile/profile.dart';
import 'package:klio/view/profile/reservation.dart';
import 'package:klio/view/profile/widgets/order_history.dart';
import 'package:klio/view_model/auth_controller.dart';
import 'package:klio/view_model/cart_controller.dart';
import 'package:klio/view_model/favourite_controller.dart';
import 'package:klio/view_model/home_controller.dart';
import 'package:klio/view_model/profile_controller.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await SharedPref().getValue('token') ?? '';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => FavouriteController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(Brightness.light),
            home: token.isEmpty? const LogIn():const CustomNavigation(),
            routes: {
              "SignUp": (ctx) => const SignUp(),
              "Verification": (ctx) => const Verification(),
              "LogIn": (ctx) => const LogIn(),
              "CustomNavigation": (ctx) => const CustomNavigation(),
              "Checkout": (ctx) => const Checkout(),
              "EditProfile": (ctx) =>  const EditProfile(),
              "Profile": (ctx) =>  const Profile(),
              "OrderHistory": (ctx) =>  const OrderHistory(),
              "EditAddress": (ctx) =>  const EditAddress(),
              "TermsAndConditions": (ctx) =>  const TermsAndConditions(),
              "OrderHistoryDetails": (ctx) => OrderHistoryDetails(),
              "Reservation": (ctx) => Reservation(),
            },
          );
        },
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primarySwatch: primarySwatch,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
  );
}
